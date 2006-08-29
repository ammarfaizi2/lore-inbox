Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWH2IA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWH2IA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWH2IA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:00:26 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:23013 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750809AbWH2IA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:00:26 -0400
Date: Tue, 29 Aug 2006 10:00:24 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Niklaus <niklaus@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SDRAM or DDRAM in linux
Message-ID: <20060829080024.GA917@rhlx01.fht-esslingen.de>
References: <85e0e3140608281040k61305f88m3f6cd4fcfddadaca@mail.gmail.com> <85e0e3140608290004u94da11dr99c4dbcc0e417d7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85e0e3140608290004u94da11dr99c4dbcc0e417d7d@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 29, 2006 at 12:34:24PM +0530, Niklaus wrote:
> Hi,
> 
> I have access to a remote linux machine. I have a root account on it.
> I need to know whether the installed RAM is SDRAM or DDRAM.
> Unfortunately i will be going to the site next month when i have to
> upgrade the machine with  more capacity. Few of them are hardware
> related but if you know the answer please help me.
> 
> 1) How do i find out when the machine is online , if it is SDRAM or
> DDRAM. I tried dmidecode utility but i was not sure about the type.
> Can someone help me out by pasting the output for both DDR and SDRAM
> in dmidecode or similar.

Try powertweak (text mode version), that can also yield pretty verbose
DMI etc. data. Might just provide that extra bit of information you need.

But with DMI info about the board manufacturer it should be very easy
to find on the internet what RAM type the board supports anyway!?

> 2) Can both SDRAM and DDRAM be present at a time in the same
> motherboard. I mean can i have 256MB of SDRAM chip and a 256 MB of
> DDRAM on the same motherboard.
> 
> If yes what are the conditions.

Yes, iff the board has both DDRAM and SDRAM slots (ECS K7S5A comes to mind,
most popularly).

> 3) Is a motherboard designed for only one type of RAM , like if we
> remove all the SDRAMs can we put DDR in it or it is either designed
> for DDR or SDRAM.

Almost all boards are *either* SDRAM *or* DDRAM, to my knowledge,
only a couple boards during the transition phase offered both slot types.

Andreas Mohr
