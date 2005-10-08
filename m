Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVJHFnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVJHFnv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 01:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJHFnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 01:43:51 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:25614 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1750767AbVJHFnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 01:43:51 -0400
Date: Sat, 8 Oct 2005 13:43:00 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Jeff Moyer <jmoyer@redhat.com>
cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
In-Reply-To: <17208.24786.729632.221157@segfault.boston.redhat.com>
Message-ID: <Pine.LNX.4.63.0510081341460.2069@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
 <17203.7543.949262.883138@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
 <17205.48192.180623.885538@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
 <17208.24786.729632.221157@segfault.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-101.4, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, RCVD_IN_ORBS,
	RCVD_IN_OSIRUSOFT_COM, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Jeff Moyer wrote:

> 
> I put together a different patch, but I want to get your input on the
> approach before I post it.  It requires both user-space and kernel-space
> changes.
> 
> Basically, you identify that a given automount tree is a direct map tree.
> This information is passed along to the kernel (I did this via a mount
> option), and recorded (in the super block info).  Then, when a directory
> lookup occurs, if we are in a direct map tree, and ghosting is enabled,
> then we pass the lookup on to the real lookup code.
> 
> I'm not sold on the approach, as I haven't thought through all of the
> implications.  Care to comment?

Can you post your patch please Jeff.

Ian

