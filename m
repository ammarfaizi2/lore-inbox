Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSIHV1F>; Sun, 8 Sep 2002 17:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSIHV1F>; Sun, 8 Sep 2002 17:27:05 -0400
Received: from 62-190-216-72.pdu.pipex.net ([62.190.216.72]:1801 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S315265AbSIHV1F>; Sun, 8 Sep 2002 17:27:05 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209082139.g88LdOOq004527@darkstar.example.net>
Subject: Re: Western Digital hard drive and DMA
To: adamjaskie@yahoo.com
Date: Sun, 8 Sep 2002 22:39:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <02090817210208.00459@aragorn> from "Adam Jaskiewicz" at Sep 08, 2002 05:21:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> turned off later in the boot process by hdparm. Could it be that I wasnt 
> using those 80 conductor cables, and was getting crosstalk? I guess i could 
> buy some to test that theory out...

Have a look at the number of UDMA CRC errors reported by

smartctl -a /dev/hda?

John
