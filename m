Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318109AbSGMG2R>; Sat, 13 Jul 2002 02:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318110AbSGMG2Q>; Sat, 13 Jul 2002 02:28:16 -0400
Received: from 62-190-201-94.pdu.pipex.net ([62.190.201.94]:23300 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S318109AbSGMG2P>; Sat, 13 Jul 2002 02:28:15 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207130636.HAA00666@darkstar.example.net>
Subject: Re: IDE/ATAPI in 2.5
To: linux-kernel@vger.kernel.org
Date: Sat, 13 Jul 2002 07:36:08 +0100 (BST)
Cc: thunder@ngforever.de, schilling@fokus.gmd.de, alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.44.0207121345180.3421-100000@hawkeye.luckynet.adm> from "Thunder from the hill" at Jul 12, 2002 01:52:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because we can't tell Linux users "your (once favorite) CD-ROM is not 
> implemented in Linux (any more), and will never ever be". If we explicitly 
> exclude hardware, where do we end?!

Like other mainstream operating systems :-)

One thing that occurs to me, but that I don't necessarily think is a good idea, is that for a long time we had "old" IDE code and "new" IDE code in the kernel, and there is no reason why we couldn't do a similar thing, (I.E. have a "legacy devices will work" foo driver, and "legacy devices might break" foo driver).  Personally I hate that idea, but maybe others will disagree.  I'd rather support all hardware forever, because the whole point is that you can compile out what you don't want, and supporting it is not causing excessive bloat.

John.
