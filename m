Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131493AbRBQBqw>; Fri, 16 Feb 2001 20:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131492AbRBQBqm>; Fri, 16 Feb 2001 20:46:42 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:26380 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S131491AbRBQBqi>; Fri, 16 Feb 2001 20:46:38 -0500
Date: Fri, 16 Feb 2001 17:46:30 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Wolfgang Teichmann <wal_teichmann@t-online.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.0/1/1-ac15 and ncr53c810a
In-Reply-To: <20010217022436.A968@werewolf.able.es>
Message-ID: <Pine.LNX.4.32.0102161739380.18153-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Wolfgang & J.A. ,

On Sat, 17 Feb 2001, J . A . Magallon wrote:
> On 02.17 Wolfgang Teichmann wrote:
> > Hello,
> > I have problems using my scanner (HP C6270A connected to ncr53c810a)
> > with xsane.
> > I always get the error message:
> > error during read: Error during device I/O
> > Feb 15 23:57:27 localhost kernel: Attached scsi generic sg2 at scsi0,
> > channel 0, id 4, lun 0, type 3
> Try disabling 'Initiate sync negotitation' in the card BIOS for the ID of
> the scanner.
	There is no Bios on an 810/810a .  There is a way to tell the
	driver not to 'initiate Sync' & I'd prolly recommend disabling
	'disconnect' as well .  UNLESSS you have -any- other device on
	the 810's scsi bus .  Please see :
	linux/drivers/scsi/EADME.ncr53c8xx
		Hth ,  JimL
       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

