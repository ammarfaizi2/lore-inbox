Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbUAELVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 06:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUAELVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 06:21:34 -0500
Received: from [217.7.64.198] ([217.7.64.198]:17289 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id S264233AbUAELVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 06:21:32 -0500
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 under vmware ?
Date: Mon, 5 Jan 2004 12:21:30 +0100
User-Agent: KMail/1.5.4
References: <1073297203.12550.30.camel@bip.parateam.prv>
In-Reply-To: <1073297203.12550.30.camel@bip.parateam.prv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401051221.30398.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 5. Januar 2004 11:06, Xavier Bestel wrote:
> Hi,
>
> I have problems running 2.6.0 under vmware (4.02 and 4.05). I did a
> basic debian/sid install, then installed various 2.6.0 kernel images
> (with or without initrd, from debian (-test9 and -test11) or self-made
> (stock 2.6.0).
> They all make /sbin/init (from sysvinit 2.85) segfault at a particular
> address (I haven't yet recompiled it with -g to see where, but a
> dissassembly shows it's a "ret").
> I try booting to /bin/sh from the initrd, and there I can play with the
> shell, mount the alternate root, play with commands there, and then exec
> /sbin/init, but it segfaults at the same point.
>
> Has anyone managed to make a basic debian with 2.6 work under vmware ?
> Has anyone managed to make another distro with 2.6 work under vmware ?

Same problem here. Tried gentoo with 2.6.0 and 2.6.1-rc1: /sbin/init will 
segfault. Testet vmware on a Dual PIII 2.4.23-pre3 and a Athlon XP with 
2.6.1-rc1.

Earny


