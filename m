Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSGHLgX>; Mon, 8 Jul 2002 07:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316848AbSGHLgW>; Mon, 8 Jul 2002 07:36:22 -0400
Received: from 62-190-219-199.pdu.pipex.net ([62.190.219.199]:2311 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S316659AbSGHLgV>; Mon, 8 Jul 2002 07:36:21 -0400
Date: Mon, 8 Jul 2002 12:44:04 +0100
From: jbradford@dial.pipex.com
Message-Id: <200207081144.MAA01244@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: Dazed and confused
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not really a bug, but FYI, when turning off power to a Toshiba T4500, it seems to generate an NMI, and the value stored in 'reason', in arch/i386/kernel/traps.c is 20.  Maybe we could use this to do something interesting on power-down, (e.g. echo "goodbye" to the screen, (I really have no work to do today, do I?  :-) )).

John.
