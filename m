Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbTBKWH2>; Tue, 11 Feb 2003 17:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbTBKWH2>; Tue, 11 Feb 2003 17:07:28 -0500
Received: from wall.ttu.ee ([193.40.254.238]:55558 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id <S266765AbTBKWH1>;
	Tue, 11 Feb 2003 17:07:27 -0500
Date: Wed, 12 Feb 2003 00:17:14 +0200 (EET)
From: Siim Vahtre <siim@pld.ttu.ee>
To: <linux-kernel@vger.kernel.org>
Subject: unable to mount 'remote' loopback block devices
Message-ID: <Pine.SOL.4.31.0302120007020.28624-100000@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

When I try to mount a 'remote' image (on NFS/samba share) I get
"ioctl: LOOP_SET_FD: Inappropriate ioctl for device"

However, when I copy that same image to local hd, it works.

2.5.59 and 2.5.60 both have the same problem, 2.4 was OK.

