Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264007AbTDJIIt (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 04:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbTDJIIt (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 04:08:49 -0400
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:36017 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP id S264007AbTDJIIs (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 04:08:48 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Re: 2.5->2.4 nfs corrupts
Date: Thu, 10 Apr 2003 08:20:27 +0000 (UTC)
Message-ID: <slrnb9aaab.17s.erik@bender.home.hensema.net>
References: <20030410013349.GC467@zip.com.au> <20030410014417.GA3197@suse.de>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones (davej@codemonkey.org.uk) wrote:
> On Thu, Apr 10, 2003 at 11:33:49AM +1000, CaT wrote:
> > nfs server: 2.4.21-pre2
> > nfs client: 2.5.67
> 
> Quite a few people (myself included) are seeing this.
> From the reports I've seen so far, it looks like it only
> happens when the client is a faster box than the server.
> In my case, I have a 2.8Ghz P4 as the client, hammering
> a poor defenceless 1Ghz VIA C3.
> 
> This is probably worth creating a bugzilla entry for.

It may be worth noting that I'm not seeing any problems between an AMD XP
1800+ client running 2.5.66-mm3 and an AMD K6-2 300 server running SuSE's
2.4.18-4GB kernel. SuSE applies quite a lot of NFS-related patches to their
kernels, if I'm not mistaken.

I'm mounting /home, /var/spool/mail and /mp3 over NFS, so I think I should
have noticed problems if there were any ;-)
-- 
Erik Hensema <erik@hensema.net>
