Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269380AbSIRWie>; Wed, 18 Sep 2002 18:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269456AbSIRWie>; Wed, 18 Sep 2002 18:38:34 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:4093 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269380AbSIRWic>; Wed, 18 Sep 2002 18:38:32 -0400
Date: Wed, 18 Sep 2002 16:41:36 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: "H. J. Lu" <hjl@lucon.org>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support tera byte disk
Message-ID: <20020918224136.GW13929@clusterfs.com>
Mail-Followup-To: Bryan O'Sullivan <bos@serpentine.com>,
	"H. J. Lu" <hjl@lucon.org>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <20020918131120.A5120@lucon.org> <20020918203247.GS13929@clusterfs.com> <1032387831.22773.27.camel@plokta.s8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032387831.22773.27.camel@plokta.s8.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 18, 2002  15:23 -0700, Bryan O'Sullivan wrote:
> On Wed, 2002-09-18 at 13:32, Andreas Dilger wrote:
> 
> > There's also a limit where statfs() overflows at 16TB for 4kB block
> > filesystems...  Ask me how I noticed this ;-)
> 
> Well, the whole world goes pear-shaped on ia32 with >16TB filesystems,
> so statfs is the least of your worries in that case :-(

Why do you say that?  I've been testing with 60TB or larger filesystems
all week ;-).  Note that we can use more than a single block device
and/or remote storage target to store data, so block device limits are
not applicable to us, although 16TB files are a limit we will hit soon.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

