Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbRCTQYA>; Tue, 20 Mar 2001 11:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbRCTQXv>; Tue, 20 Mar 2001 11:23:51 -0500
Received: from [195.193.201.73] ([195.193.201.73]:62724 "EHLO
	mondriaan.macroscoop.nl") by vger.kernel.org with ESMTP
	id <S130497AbRCTQXi>; Tue, 20 Mar 2001 11:23:38 -0500
From: "Pim Zandbergen" <P.Zandbergen@macroscoop.nl>
To: "Robert Miciovici" <Robert_Miciovici@adsweu.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: IBM ServeRAID 4L firmware 4.40.03
Date: Tue, 20 Mar 2001 17:22:03 +0100
Message-ID: <NCBBJAAFLJPMOAOEDDEDIEPACGAA.P.Zandbergen@macroscoop.nl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
In-Reply-To: <OFAAC92024.5E0C458D-ONC2256A0F.007E98DB@pav.uk.ema.adsw.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001 23:19:05 GMT, Robert Miciovici wrote:

>look what I get on one of the installation log screens:
>
>* Cannot find /tmp/drivers/rhdd-6.1; bad driver disk
>* Cannot find /tmp/drivers/modinfo; bad driver disk
>* Cannot find /tmp/drivers/modules.dep; bad driver disk
>* Cannot find /tmp/drivers/pcitable; bad driver disk

[ ... ]

>What do you say, how should I approach this one?

Are you using the right version of the driver disk and
firmware? It should be 4.50.

You best download the latest ServeRAID Support CD image:
ftp://ftp.pc.ibm.com/pub/pccbbs/pc_servers/25p2529.iso

You can upgrade your ServeRAID firmware & BIOS by booting
from this CD, and it contains a driver disk floppy image
that supports installing RedHat 7.0. It worked for me.

Supposedly there's a version 4.70 coming soon that will
suppport kernel 2.4. The current 4.50 driver is unstable
on kernel 2.4.
