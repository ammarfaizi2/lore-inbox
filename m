Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTKGWC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbTKGV7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 16:59:40 -0500
Received: from AGrenoble-101-1-5-128.w80-11.abo.wanadoo.fr ([80.11.136.128]:45777
	"EHLO awak") by vger.kernel.org with ESMTP id S264003AbTKGJrR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:47:17 -0500
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: bill davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FAAB8B5.6060901@gmx.de>
References: <3FA69CDF.5070908@gmx.de> <3FA8C916.3060702@gmx.de>
	 <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de>
	 <boe68a$f3g$1@gatekeeper.tmr.com>  <3FAAB8B5.6060901@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1068198396.5597.62.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 07 Nov 2003 10:46:37 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 06/11/2003 à 22:10, Prakash K. Cheemplavam a écrit :
> c) That scsi gets selected when using usbfs seams to be some sort of 
> wrapper being used...(just guessing without actually knowing the code). 
> WOuld be nice if a note in the kernel menuconfig or alike would be left 
> so that one doesn't have to wonder... But IIRC usbfs will be dropped anyway.

SCSI is not used for usbfs. It's simply the protocol for USB storage
devices (same case as FireWire/IEEE1394 storage devices). So it won't
get dropped any sooner. As SATA devices may be using SCSI in linux soon,
it even could be always selected.

	Xav

