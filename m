Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285362AbRLGBgn>; Thu, 6 Dec 2001 20:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285364AbRLGBgd>; Thu, 6 Dec 2001 20:36:33 -0500
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:16547 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S285362AbRLGBg2>; Thu, 6 Dec 2001 20:36:28 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: john@deater.net, linux-kernel@vger.kernel.org
In-Reply-To: <20011206170335.03856f7b.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy>
	<1007685691.6675.1.camel@localhost.localdomain> 
	<20011206170335.03856f7b.rddunlap@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 06 Dec 2001 17:27:20 -0800
Message-Id: <1007688442.6675.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-06 at 17:03, Randy.Dunlap wrote:
> Hi-
> 
> Did your search for "$PIR" or "RIP$" ?
> It is suppsed to be the latter (little-endian).

Tried both. The flash BIOS update might be reading system specific stuff
and then appending it to the new update, though. Maybe they have
separate "code" and data areas, and the the data part never gets
overwritten.

Would you happen to have any thoughts or advice WRT the problem we have
and the proper method of addressing it? Absent a BIOS fix, of course,
which I imagine would be the ultimate solution.

-Cory

