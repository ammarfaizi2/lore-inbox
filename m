Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTK3LRY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 06:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbTK3LRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 06:17:24 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:58723 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S264884AbTK3LRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 06:17:23 -0500
Date: Sun, 30 Nov 2003 11:16:31 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Andrew Clausen <clausen@gnu.org>
cc: Andries Brouwer <aebr@win.tue.nl>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
In-Reply-To: <20031129223349.GC505@gnu.org>
Message-ID: <Pine.LNX.4.58.0311301034360.2329@ua178d119.elisa.omakaista.fi>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl>
 <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
 <20031129223349.GC505@gnu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Nov 2003, Andrew Clausen wrote:
> 
> Good question.  From 98 up, Windows supports both LBA and CHS.  I'm not
> sure about XP/2003.  

I don't think it changed. CHS support is needed for backward compatibility
during boot. This is why it would be important not to screw it, if it's
indeed matter in the partition table. Some reading how NT gets/uses drive
geometry,
	
	http://support.microsoft.com/?kbid=98080

> The real question is: what is the default install? How many users have
> each?

Google Zeitgeist says for september at 
http://www.google.com/press/zeitgeist/sep03_pie.gif

	XP    38% 
	98    29%
	2000  20%
	NT     3%
	95     1%

XP is growing 1-2% each month at the expense of Win9x (see
http://www.google.com/press/zeitgeist//{...,jun,jul,aug}03_pie.gif)

The majority of NT based uses NTFS. NTFS has its own $Boot file fixed at
sector 0, that is it's the boot sector. I don't know how much it's
different from the one booting from FAT but I guess not much (except of 
understanding NTFS instead of FAT during boot, etc).
 
	Szaka
