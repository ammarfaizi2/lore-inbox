Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTFONP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 09:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFONP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 09:15:29 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:52236 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262223AbTFONPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 09:15:24 -0400
Date: Sun, 15 Jun 2003 15:29:11 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71
In-Reply-To: <Pine.LNX.4.44.0306141411320.2156-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.51L.0306151526190.11459@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0306141411320.2156-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jun 2003, Linus Torvalds wrote:
> I think I'll call this kernel the "sticky turtle", in honor of that
> historic "greased weasel" kernel, and as a comment on how sadly
> dependent I've become on the daily BK snapshots. It's been too long
> since 2.5.70.

well done - this kernel looks really good. Even building is cleaner...

But - I get now after make modules_install:
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.71; fi
WARNING: /lib/modules/2.5.71/kernel/drivers/char/agp/nvidia-agp.ko needs unknown symbol agp_memory_reserved
WARNING: /lib/modules/2.5.71/kernel/drivers/net/3c509.ko needs unknown symbol netdev_boot_setup_check

My kernel config:
http://piorun.ds.pg.gda.pl/~blues/kernel-2.5/config-2.5.71.txt

-- 
pozdr.  Pawe³ Go³aszewski 
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
