Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSINQ5h>; Sat, 14 Sep 2002 12:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSINQ5h>; Sat, 14 Sep 2002 12:57:37 -0400
Received: from 62-190-202-1.pdu.pipex.net ([62.190.202.1]:41732 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S317371AbSINQ5g>; Sat, 14 Sep 2002 12:57:36 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209141709.g8EH9Bts002237@darkstar.example.net>
Subject: Re: Possible bug and question about ide_notify_reboot in drivers/ide/ide.c (2.4.19)
To: alex14641@yahoo.com (Alex Davis)
Date: Sat, 14 Sep 2002 18:09:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020913023744.78077.qmail@web40510.mail.yahoo.com> from "Alex Davis" at Sep 12, 2002 07:37:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Second, why do we need to put the disks on standby before halting?

So that data that is in their internal RAM cache is flushed before the power is switched off.

> I ask because putting the disks on standby puts my hard drives into a coma!!
> When I power up after a halt, I have to go into the BIOS and force auto-detect to wake
> them back up. I've removed the "standby" code and things seem to be functioning normally.

That is very strange.

> I have an Epox 8K7A motherboard with two Maxtor Hard drives (model 5T040H4).

Never experienced that with a Maxtor hard disk.  Best person to ask would be Alan.

John.
