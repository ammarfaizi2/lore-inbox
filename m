Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311147AbSDCL2H>; Wed, 3 Apr 2002 06:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311206AbSDCL16>; Wed, 3 Apr 2002 06:27:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56081 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311147AbSDCL1k>; Wed, 3 Apr 2002 06:27:40 -0500
Subject: Re: Ext2 vs. ext3 recovery after crash
To: davidsen@tmr.com (Bill Davidsen)
Date: Wed, 3 Apr 2002 12:41:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel Mailing List)
In-Reply-To: <Pine.LNX.3.96.1020402225256.9671A-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Apr 02, 2002 11:02:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16sj90-0003aq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> style multi-pass 12 minute recovery. I don't see why the ext3 isn't always
> used, I know it's going to crash, I always do a sync and wait ten seconds
> for journal writes, etc, to take place.

tune2fs - the file system has a pair of values that force a check every
n mounts and every n days. You can modify these.

Alan
