Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270330AbTGRSzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 14:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271757AbTGRSzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 14:55:41 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:6881 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S270330AbTGRSzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 14:55:37 -0400
Date: Fri, 18 Jul 2003 15:10:16 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Christophe Saout <christophe@saout.de>
cc: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>,
       Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: RE: Partitioned loop device..
In-Reply-To: <1058538027.19986.3.camel@chtephan.cs.pocnet.net>
Message-ID: <Pine.LNX.4.56.0307181508490.11351@filesrv1.baby-dragons.com>
References: <E1B7C89B8DCB084C809A22D7FEB90B3840AB@frodo.avalon.ru>
 <1058538027.19986.3.camel@chtephan.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.56.0307181508492.11351@filesrv1.baby-dragons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Christophe ,  Are the tools you use in this script only for
	2.5/2.6 ?  Tia ,  JimL
On Fri, 18 Jul 2003, Christophe Saout wrote:
> Am Di, 2003-07-15 um 20.32 schrieb Dimitry V. Ketov:
> > > You can already use Device-Mapper to create "partitions" on
> > > your loop devices,
> > You're right but I want _partitions_ but not "partitions" ;)
> > It should appears like a real hardware disk, not virtual one.
> I just hacked up an ugly small shell script, that uses sfdisk and
> dmsetup to create the partition devices over any block device.
> Just dmsetup-partitions /dev/loop0 or something.
> It will then create devices /dev/mapper/loop0p1, etc... just like hda1
> and so on. To remove them use "dmsetup remove loop0p1", etc...
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
