Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWGICxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWGICxl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 22:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWGICxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 22:53:40 -0400
Received: from cs.columbia.edu ([128.59.16.20]:16625 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S1161069AbWGICxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 22:53:40 -0400
Subject: Re: [RFC] VFS: FS CoW using redirection
From: Shaya Potter <spotter@cs.columbia.edu>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200607082041.54489.a1426z@gawab.com>
References: <200607082041.54489.a1426z@gawab.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 22:53:30 -0400
Message-Id: <1152413610.19065.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 20:41 +0300, Al Boldi wrote:
> Copy on Write is a neat way to quickly achieve a semi-clustered system, by 
> mounting any shared FS read-only and redirecting writes to some perClient 
> FS.
> 
> Would this redirection be easy to implement into the VFS?

I've used unionfs that way.

