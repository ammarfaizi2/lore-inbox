Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSJASBE>; Tue, 1 Oct 2002 14:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262256AbSJASBC>; Tue, 1 Oct 2002 14:01:02 -0400
Received: from 62-190-218-51.pdu.pipex.net ([62.190.218.51]:56580 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262223AbSJASAZ>; Tue, 1 Oct 2002 14:00:25 -0400
Date: Tue, 1 Oct 2002 19:14:14 +0100
From: jbradford@dial.pipex.com
Message-Id: <200210011814.g91IEEY5007979@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: Stupid luser question
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wondering, what is the purpose of the comment /* { */ which is found in various seemingly random places in the kernel:

# grep -F -r "/* { */" *

drivers/video/font_acorn_8x8.c:/* 7B */  0x0C, 0x18, 0x18, 0x70, 0x18, 0x18, 0x0C, 0x00, /* { */
drivers/scsi/scsi_syms.c:#if defined(CONFIG_SCSI_LOGGING)       /* { */
drivers/scsi/scsi.c:#ifdef CONFIG_SCSI_LOGGING          /* { */
drivers/scsi/scsi.c:#ifdef CONFIG_SCSI_LOGGING          /* { */
drivers/message/fusion/mptbase.h:#ifdef __KERNEL__      /* { */
drivers/message/fusion/mptscsih.c:#ifndef MPT_SCSI_USE_NEW_EH   /* { */
drivers/message/fusion/mptscsih.c:#ifdef MPT_SCSI_USE_NEW_EH            /* { */
drivers/message/fusion/mptscsih.c:#if 0         /* { */
drivers/message/fusion/mptbase.c:#ifdef CONFIG_PROC_FS              /* { */

John.
