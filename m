Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264239AbUEMOMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbUEMOMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 10:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUEMOKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 10:10:42 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:34825 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264226AbUEMOKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 10:10:08 -0400
Date: Thu, 13 May 2004 22:08:34 +0800 (WST)
From: raven@themaw.net
To: Paul Jakma <paul@clubi.ie>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux autofs <autofs@linux.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [autofs] Badness in interruptible_sleep_on
In-Reply-To: <Pine.LNX.4.58.0405081324440.2371@donald.themaw.net>
Message-ID: <Pine.LNX.4.58.0405132202340.13693@donald.themaw.net>
References: <Pine.LNX.4.58.0405070532500.1979@fogarty.jakma.org>
 <Pine.LNX.4.58.0405071426500.11299@wombat.indigo.net.au>
 <Pine.LNX.4.58.0405072321530.1979@fogarty.jakma.org>
 <Pine.LNX.4.58.0405081324440.2371@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2004 raven@themaw.net wrote:

> > 
> > PS: Arjan, any chance of a kernel with davej's NFS stack fixes and 
> > the autofs badness fixes? would be much appreciated!
> 
> While I have some patch sets around for earlier 2.6 kernels I advise 
> against using them.
> 
> I'm in the process of making "single file" patches for the earlier kernels 
> with all the updates that are in 2.6.6-rc3-mm2.
> 
> As an aside the same goes for the 2.4 patches.
> 
> I'll let you know when it's done. I expect to finish this weekend.

Sorry to take so long to get back.

The patches have been at
http://www.kernel.org/pub/linux/kernel/people/raven
for a while.

There is one for 2.6.0 and the 2.6.4 one caters a change that was made.
The autofs4-2.6.6-rc3-mm2-compat_ioctls.patch is to update the 32 <-> 
64 bit ioctl emulation and should apply with a small offset.

Ian

