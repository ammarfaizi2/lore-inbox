Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933843AbWLAPJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933843AbWLAPJa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935044AbWLAPJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:09:30 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:31689 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S933843AbWLAPJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:09:30 -0500
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable
	hyper-threading.
From: Ben Collins <ben.collins@ubuntu.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <1164983529.3233.73.camel@laptopd505.fenrus.org>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
	 <11648607733630-git-send-email-bcollins@ubuntu.com>
	 <20061201132918.GB4239@ucw.cz>  <1164980500.5257.922.camel@gullible>
	 <1164983529.3233.73.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Dec 2006 10:09:17 -0500
Message-Id: <1164985757.5257.933.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 15:32 +0100, Arjan van de Ven wrote:
> > 
> > The idea is that we want our users to be able to use hyper-threading,
> > but we don't want it on by default.
> 
> Hi,
> 
> can I ask why not?

I'm just basing this on the history of the patch, which preceeds me, so
if this is incorrect, please don't blame me for misinformation :)

The original patch claims that hyper-threading opens the user up to some
sort of security risk involving hardware limitations in protecting
memory across the threads. I can't recall all the details.

If this is wrong, I'm more than happy to just drop the whole damn patch.
