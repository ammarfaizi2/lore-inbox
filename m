Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318268AbSHIMvd>; Fri, 9 Aug 2002 08:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318269AbSHIMvd>; Fri, 9 Aug 2002 08:51:33 -0400
Received: from 62-190-200-223.pdu.pipex.net ([62.190.200.223]:25860 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S318268AbSHIMvd>; Fri, 9 Aug 2002 08:51:33 -0400
Date: Fri, 9 Aug 2002 14:01:46 +0100
From: jbradford@dial.pipex.com
Message-Id: <200208091301.g79D1kIA000276@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: No reset of IDE disk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.4.19, when I use:

hdparm -Y /dev/hda

to put my Maxtor IDE HD in to 'Sleep' mode, it doesn't get automatically woken up again when it's accessed.  I presume that this is a kernel issue, (an interrupt not being issued), because resetting the device with:

hdparm -w /dev/hda

restarts it successfully.

This is using a PIIX3 IDE interface, incidently.

John.
