Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288473AbSA0Tmw>; Sun, 27 Jan 2002 14:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288484AbSA0Tmm>; Sun, 27 Jan 2002 14:42:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33289 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288473AbSA0Tma>; Sun, 27 Jan 2002 14:42:30 -0500
Subject: Re: file system unmount
To: gspujar@hss.hns.com
Date: Sun, 27 Jan 2002 19:55:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <65256B4A.003D4CD1.00@sandesh.hss.hns.com> from "gspujar@hss.hns.com" at Jan 23, 2002 04:43:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UvOM-0002Mf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am using softdog in my application. One of the problems I am facing is,
> when the system comes up after the reboot forced by softdog, file system gets
> corrupted and fsck has to check. Some times fsck fails to force check the file
> system and
> the system enters in to run level 1, leading to manual intervention.

Convert the file system to ext3 and use ext3, then you will get a few second
pause on the journal playback and the machine will return without an fsck
being needed
