Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWJMNoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWJMNoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWJMNoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:44:23 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:17045 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750797AbWJMNoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:44:22 -0400
Date: Fri, 13 Oct 2006 15:41:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Andrew Morton <akpm@osdl.org>, Josef Jeff Sipek <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00 of 23][-mm] Unionfs: Stackable Namespace Unification
 Filesystem
In-Reply-To: <84144f020610122354s3f217a7fh1500f82da25f4739@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0610131540280.18631@yvahk01.tjqt.qr>
References: <patchbomb.1160633917@thor.fsl.cs.sunysb.edu> 
 <20061012135428.024d0d33.akpm@osdl.org> <84144f020610122354s3f217a7fh1500f82da25f4739@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Meanwhile, from a quick scan I'd say that unionfs is much, much too
>> lightly
>> commented for a review to be particularly effective.   Please work on
>> that.
>
> - Kill wrappers (e.g. unionfs_kill_block_super can be replaced with
> generic_shutdown_super)

Possibly the unionfs_kill_block_super function was once written with 
more than just generic_shutdown_super in mind. Just a guess, though.


	-`J'
-- 
