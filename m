Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbSLKDZZ>; Tue, 10 Dec 2002 22:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbSLKDZY>; Tue, 10 Dec 2002 22:25:24 -0500
Received: from pcp02781107pcs.eatntn01.nj.comcast.net ([68.85.61.149]:42490
	"EHLO linnie.riede.org") by vger.kernel.org with ESMTP
	id <S266987AbSLKDZY>; Tue, 10 Dec 2002 22:25:24 -0500
Date: Tue, 10 Dec 2002 22:33:12 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-kernel@vger.kernel.org
Subject: drivers/video/sis horribly broken in 2.5.51
Message-ID: <20021211033312.GN3664@linnie.riede.org>
Reply-To: wrlk@riede.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.5.51 appears to have horribly broken the files in
drivers/video/sis. linux-2.5.51/drivers/video/sis/sis_main.c
refers to #include <video/fbcon.h>, <video/fbcon-cfb8.h>,
<video/fbcon-cfb16.h>, <video/fbcon-cfb24.h>, <video/fbcon-cfb32.h>
which appears to have been removed from the tree. And who knows
what other havoc has been created :-(

Does anyone know how to fix this?

Thanks, Willem Riede.
