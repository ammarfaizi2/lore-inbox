Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271009AbSISK2y>; Thu, 19 Sep 2002 06:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271016AbSISK2y>; Thu, 19 Sep 2002 06:28:54 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:37535 "EHLO
	picard.csi-inc.com") by vger.kernel.org with ESMTP
	id <S271009AbSISK2x>; Thu, 19 Sep 2002 06:28:53 -0400
Message-ID: <00a901c25fc8$08c5bdb0$f6de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "Andreas Dilger" <adilger@clusterfs.com>,
       "Bryan O'Sullivan" <bos@serpentine.com>
Cc: "H. J. Lu" <hjl@lucon.org>, "linux kernel" <linux-kernel@vger.kernel.org>
References: <20020918131120.A5120@lucon.org> <20020918203247.GS13929@clusterfs.com> <1032387831.22773.27.camel@plokta.s8.com> <20020918224136.GW13929@clusterfs.com>
Subject: Re: PATCH: Support tera byte disk
Date: Thu, 19 Sep 2002 06:33:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ummm...could you edumacate us on how one constructs a 60TB file system on IA32???
I thought 2TB was the limit.
I'm particularly interested if this is RAID too (I'm a RAID5 fan).
I'm trying to avoid NAS for my next file system upgrade.

----- Original Message ----- 
From: "Andreas Dilger" <adilger@clusterfs.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: "H. J. Lu" <hjl@lucon.org>; "linux kernel" <linux-kernel@vger.kernel.org>
Sent: Wednesday, September 18, 2002 6:41 PM
Subject: Re: PATCH: Support tera byte disk


> On Sep 18, 2002  15:23 -0700, Bryan O'Sullivan wrote:
> > On Wed, 2002-09-18 at 13:32, Andreas Dilger wrote:
> > 
> > > There's also a limit where statfs() overflows at 16TB for 4kB block
> > > filesystems...  Ask me how I noticed this ;-)
> > 
> > Well, the whole world goes pear-shaped on ia32 with >16TB filesystems,
> > so statfs is the least of your worries in that case :-(
> 
> Why do you say that?  I've been testing with 60TB or larger filesystems
> all week ;-).  Note that we can use more than a single block device
> and/or remote storage target to store data, so block device limits are
> not applicable to us, although 16TB files are a limit we will hit soon.
> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> http://sourceforge.net/projects/ext2resize/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
