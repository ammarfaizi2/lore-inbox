Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSCZM67>; Tue, 26 Mar 2002 07:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311471AbSCZM6t>; Tue, 26 Mar 2002 07:58:49 -0500
Received: from ausxc07.us.dell.com ([143.166.227.166]:34991 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S293276AbSCZM6j>; Tue, 26 Mar 2002 07:58:39 -0500
Message-ID: <71714C04806CD51193520090272892170452B50D@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: t-kawano@ebina.hitachi.co.jp, linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org
Subject: RE: [PATCH]fix for double free in efi.c
Date: Tue, 26 Mar 2002 06:58:30 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following is a fix for a double free bug in fs/partitions/efi.c.

Indeed, this was pointed out a couple weeks ago and since fixed in the IA-64
port.  I'm readying a cleanup around EFI's use of GUIDs which affects
fs/partitions/efi.[ch] too and hope to have that ready to submit yet this
week.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001! (IDC Mar 2002)
