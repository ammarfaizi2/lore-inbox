Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSGLKoL>; Fri, 12 Jul 2002 06:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSGLKoK>; Fri, 12 Jul 2002 06:44:10 -0400
Received: from 62-190-200-105.pdu.pipex.net ([62.190.200.105]:41477 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S315925AbSGLKoK>; Fri, 12 Jul 2002 06:44:10 -0400
Date: Fri, 12 Jul 2002 11:52:02 +0100
From: jbradford@dial.pipex.com
Message-Id: <200207121052.LAA01947@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel config etiquette
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to write a patch to sync the disks on my laptop when an NMI with id 20 occurs, which happens when the battery runs out, or you turn it off, (I.E. at the moment it beeps, saying "Dazed and confused", then 1 second later powers down.  I want to use that 1 sec to sync the disk in case the battery runs out while I'm just sitting at the command line).

I'm adding code to /arch/i386/kernel/traps.c to deal with this and, <luser_question>it suddenly occurred to me that I'd need to add an "Enable T4500 syncing on powerdown Y/N" to the kernel config.  I've read the F.A.Q. and can't work out if there is a standard etiquette to be followed when doing this</luser_question> can somebody advise me, please?

Cheers,
John.
