Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTL2Qi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTL2Qi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:38:56 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:24960 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S263491AbTL2Qiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:38:55 -0500
Date: Mon, 29 Dec 2003 17:38:53 +0100
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Can't mount USB partition as root
Message-ID: <20031229173853.A32038@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I tried to boot Linux 2.6.0 kernel with option root=/dev/sda1 using Grub.
The kernel otherwise works, mounts the sda1 partition (XFS) OK.
When I boot the kernel with root=/dev/sda1 instead of root=/dev/hda4,
I get "can't mount root VFS, kernel panic" or something like that.

Is it possible to boot kernel with root from /dev/sda1 (USB)?
partition table: whole /dev/sda is one partition (sda1), type 83 (Linux).
Tried also switching on and off hotplugging in kernel and it didn't help.

Cl<
