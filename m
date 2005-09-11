Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVIKLop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVIKLop (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 07:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVIKLop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 07:44:45 -0400
Received: from science.horizon.com ([192.35.100.1]:19510 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932423AbVIKLop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 07:44:45 -0400
Date: 11 Sep 2005 07:44:35 -0400
Message-ID: <20050911114435.5990.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Cc: Valdis.Kletnieks@vt.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll bite - what distros are shipping a kernel 2.6.10 or later and still
> using devfs?

Debian.  The current Debian installer is unfortunately rather tightly
coupled to devfs; the reasons for choosing it are rooted in boot floppy
size, but the development ("unstable") install image uses 2.6.12 + devfs.

I just had to do a little dance to install it on a machine where
2.6.12 didn't recognize the SATA controller but 2.6.13 counldn't
run the installer.

Note that Debian doesn't need devfs in normal operation; it's just
a bootstrapping tool.
