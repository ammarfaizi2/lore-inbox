Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbRLEWyS>; Wed, 5 Dec 2001 17:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284792AbRLEWyI>; Wed, 5 Dec 2001 17:54:08 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:49455 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S284794AbRLEWxs>; Wed, 5 Dec 2001 17:53:48 -0500
Date: Thu, 6 Dec 2001 00:53:42 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Anthony DeRobertis <asd@suespammers.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPT370 (KT7A-RAID) *corrupts* data - SAMSUNG SV8004H does it as well
Message-ID: <20011206005342.D12063@niksula.cs.hut.fi>
In-Reply-To: <20011201115803.B10839@viasys.com> <8519E629-E905-11D5-828E-00039355CFA6@suespammers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8519E629-E905-11D5-828E-00039355CFA6@suespammers.org>; from asd@suespammers.org on Tue, Dec 04, 2001 at 05:23:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 05:23:19PM -0500, you [Anthony DeRobertis] claimed:
> Setup here is:
> 
> hde: WDC WD200EB-00BHF0, ATA DISK drive
> hdg: WDC WD200EB-00BHF0, ATA DISK drive
> 
> hde: 39102336 sectors (20020 MB) w/2048KiB Cache, 
> CHS=38792/16/63, UDMA(100)
> hdg: 39102336 sectors (20020 MB) w/2048KiB Cache, 
> CHS=38792/16/63, UDMA(100)
> 
> 5GB of each in RAID0 on /dev/md/2
> 
> cat /dev/md/2 | md5sum now done its fourth run; all OK. 
> 920b175a519b578dcd7862b720eb9efb, if you care ;-)

I do care (not of the sum, but of the fact your sums are consistent). Thank
you for testing!
 
> This is 2.4.6, on a KT7-RAID board.

So it is KT7-RAID, not KT7A-RAID like mine... Could that have something to
do with it...


-- v --

v@iki.fi
