Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318841AbSICRSY>; Tue, 3 Sep 2002 13:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318845AbSICRSX>; Tue, 3 Sep 2002 13:18:23 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:48512 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318841AbSICRSX>; Tue, 3 Sep 2002 13:18:23 -0400
Date: Tue, 3 Sep 2002 11:23:01 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Hacksaw <hacksaw@hacksaw.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c 
In-Reply-To: <200209022233.g82MXXgB015673@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.44.0209031118300.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Sep 2002, Hacksaw wrote:
> 1. It's useful to have a physical disk divided into multiple logical disks.
> 2. It's therefore important that the bootloader know about them, assuming that 
> we want to be able to boot from any logical disk.
> 3. We can either have the bootloader spend time divining the structure of the 
> logical disks by scanning the physical disk or we can write it down in some 
> useful place.
> 4. That useful place is very near the front of the physical disk.

My "visions" go elsewhere:

The users who still need partition tables shall get theirs in a sane way 
-- maybe as David Miller proposed, or just simple Sun-styled partition 
tables (even though I don't think they're _much_ saner than PC partition 
tables).

And the second thing is about your point one. We have two big raid arrays 
divided into three racks. Here we have one logical disk divided into many 
physical disks. If you want to know the constraints, call the controller 
and ask for it. The rest is bogus -- why should I have a partition table? 
Maybe divide the raid into smaller disks?!

That's it.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

