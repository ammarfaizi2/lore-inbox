Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbULPLYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbULPLYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 06:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbULPLYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 06:24:50 -0500
Received: from mailhub2.nextra.sk ([195.168.1.110]:26373 "EHLO toe.nextra.sk")
	by vger.kernel.org with ESMTP id S261923AbULPLYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 06:24:48 -0500
Message-ID: <41C1709E.9000406@rainbow-software.org>
Date: Thu, 16 Dec 2004 12:25:18 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Park Lee <parklee_sel@yahoo.com>, dave@lafn.org,
       linux-kernel@vger.kernel.org
Subject: Re: Issue on connect 2 modems with a single phone line
References: <20041215184206.43601.qmail@web51505.mail.yahoo.com> <20041216010138.GC6285@elf.ucw.cz>
In-Reply-To: <20041216010138.GC6285@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
 > Hi!
 >
 >
 >>  I want to try serial console in order to see the
 >>complete Linux kernel oops.
 >>  I have 2 computers, one is a PC, and the other is a
 >>Laptop. Unfortunately,my Laptop doesn't have a serial
 >>port on it. But then, the each machine has a internal
 >>serial modem respectively.
 >>  Then, can I use a telephone line to directly connect
 >>the two machines via their internal modems (i.e. One
 >>end of the telephone line is plugged into The PC's
 >>modem, and the other end is plugged into The Laptop's
 >>modem directly), and let them do the same function as
 >>two serial ports and a null modem can do? If it is,
 >>How to achieve that?
 >
 >
 > You'd need phone exchange to do this. Most modems will not talk using
 > simple cable. With 12V power supply and resistor phone exchange is
 > quite easy to emulate, but...
 > 								Pavel

I've tried it with 2 older Microcom modems and a piece of cable and it 
worked. Opened terminal on both sides, wrote ATDT123 (or any number you 
like) and ATA on the other. But if the laptop modem is a software modem, 
this will not work.

-- 
Ondrej Zary
