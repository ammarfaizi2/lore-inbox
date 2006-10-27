Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946264AbWJ0Jfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946264AbWJ0Jfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 05:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946266AbWJ0Jfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 05:35:53 -0400
Received: from tim.rpsys.net ([194.106.48.114]:41349 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1946264AbWJ0Jfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 05:35:52 -0400
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
From: Richard Purdie <rpurdie@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <4541C1B2.7070003@yahoo.com.au>
References: <1161935995.5019.46.camel@localhost.localdomain>
	 <4541C1B2.7070003@yahoo.com.au>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 10:35:37 +0100
Message-Id: <1161941737.5019.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 18:22 +1000, Nick Piggin wrote:
> This is the right approach to handling swap write errors. However, you need
> to cut down on the amount of code duplication.

I've just looked at this and there isn't that much code duplicated, just
a couple of big comment blocks which make it look like that. Those
sections are similar in spirit but have been modified to work under
different circumstances. Having looked again, I don't think its worth
trying to merge them as it will become too unreadable.

Cheers,

Richard



