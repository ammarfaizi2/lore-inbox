Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWEKQtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWEKQtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWEKQtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:49:36 -0400
Received: from iabervon.org ([66.92.72.58]:33550 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030349AbWEKQtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:49:35 -0400
Date: Thu, 11 May 2006 12:50:30 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.16
In-Reply-To: <296295514.20060511123419@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.64.0605111246150.6713@iabervon.org>
References: <20060511022547.GE25010@moss.sous-sol.org>
 <296295514.20060511123419@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006, Maciej Soltysiak wrote:

> Hello Chris,
> 
> Thursday, May 11, 2006, 4:25:47 AM, you wrote:
> > Trond Myklebust:
> >       fs/locks.c: Fix lease_init (CVE-2006-1860)
> I want to say that I like the quick stable cycle. People like to see
> fixes. Big thanks!
> 
> However...
> I must say that usually I know if I need the the update,
> eg. I do not care for SCTP that much so I could skip that update.
> 
> But this one looks important, something that every kernel build
> has in its code path, however I am unable to say if I need it badly
> or maybe not.

It looks from the commit that it is a user-triggerable lockup and memory 
leak. Perhaps the posting of the patch should include the comments?

	-Daniel
*This .sig left intentionally blank*
