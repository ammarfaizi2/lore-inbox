Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262379AbSJPKV2>; Wed, 16 Oct 2002 06:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSJPKV2>; Wed, 16 Oct 2002 06:21:28 -0400
Received: from 62-190-202-100.pdu.pipex.net ([62.190.202.100]:28164 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262379AbSJPKV1>; Wed, 16 Oct 2002 06:21:27 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210161035.g9GAZsZb004891@darkstar.example.net>
Subject: [BUG] 2.5.43 IDE not powered down on shutdown
To: alan@lxorguk.ukuu.org.uk
Date: Wed, 16 Oct 2002 11:35:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.43 doesn't power down IDE devices on shutdown on my 486 laptop.
2.5.42 did.

However, the disk squeeks on shutdown, which I am positive is due to
it being sent a spin down command, followed immediately by a spin-up command.

I think this might be a result of the discussion about not powering
down devices over a re-boot, as I think Slackware uses slightly
different options to halt on a shutdown than is usual, (but I could be
wrong).

I haven't had time to try 2.5.43 on other machines yet, but I will do
later on today.

John.
