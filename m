Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUBXPam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbUBXPam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:30:42 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:49039 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S262273AbUBXPal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:30:41 -0500
To: linux-kernel@vger.kernel.org
Subject: Why are 2.6 modules so huge?
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Tue, 24 Feb 2004 10:30:39 -0500
Message-ID: <9cfptc4lckg.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can anyone help me understand why 2.6-series kernel modules are so
huge?

$ cd /lib/modules
$ ls -l */kernel/fs/vfat
2.4.20-18.8bigmem/kernel/fs/vfat:
total 20
-rw-r--r--    1 root     root        17678 May 29  2003 vfat.o

2.4.23-xfs/kernel/fs/vfat:
total 20
-rw-r--r--    1 root     root        17614 Dec  3 18:04 vfat.o

2.6.0/kernel/fs/vfat:
total 288
-rw-r--r--    1 root     root       288738 Feb 11 16:47 vfat.ko

2.6.3/kernel/fs/vfat:
total 288
-rw-r--r--    1 root     root       289086 Feb 24 10:09 vfat.ko

Ian

