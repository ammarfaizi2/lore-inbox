Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWA3QLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWA3QLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWA3QLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:11:17 -0500
Received: from tassadar.physics.auth.gr ([155.207.123.25]:44003 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S932354AbWA3QLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:11:16 -0500
Date: Mon, 30 Jan 2006 18:11:03 +0200 (EET)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: RAID autodetection not working when booting with initramfs
In-Reply-To: <17373.20667.838469.977966@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0601301808180.24345@tassadar.physics.auth.gr>
References: <Pine.LNX.4.64.0601300103110.2016@tassadar.physics.auth.gr>
 <17373.20667.838469.977966@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	/*
> 	 * check if there is an early userspace init.  If yes, let it do all
> 	 * the work
> 	 */
>
> So yes, it is by design.  Assembling arrays with mdadm gives you a
> lot more control than the kernel-autodetect so as you have an
> initramfs, it is a good idea to make use of it.
>
> If you *really* want to use the autodetect functionality, you can look
> around for a program called 'raidautorun'.  It does triggers the
> autodetect function from userspace.
>

 	Thank you , raidautorun did the trick. I am trying to build an 
initramfs as much generic as possible to be used with hundreds of systems, 
so doing a custom image for every possible raid combination is really not 
an options compared to autodetection.

 	Thnx again,

--
============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
============================================================================
