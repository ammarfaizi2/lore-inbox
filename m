Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285380AbRLSQdB>; Wed, 19 Dec 2001 11:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285378AbRLSQcv>; Wed, 19 Dec 2001 11:32:51 -0500
Received: from bigspace.hitnet.RWTH-Aachen.DE ([137.226.181.2]:14634 "EHLO
	bigspace.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S285379AbRLSQch>; Wed, 19 Dec 2001 11:32:37 -0500
Date: Wed, 19 Dec 2001 17:32:32 +0100
From: Thomas Deselaers <thomas@deselaers.de>
To: linux-kerne <linux-kernel@vger.kernel.org>
Subject: Re: IDE Harddrive Performance
Message-ID: <20011219163232.GC4259@leukertje.hitnet.rwth-aachen.de>
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de> <20011219155538.BF29F3B92@dnph.phys.msu.su> <20011219160529.GA3930@leukertje.hitnet.rwth-aachen.de> <20011219161535.43EE17925@dnph.phys.msu.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011219161535.43EE17925@dnph.phys.msu.su>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 07:15:34PM +0300, Oleg Artamonov wrote:
> > leukertje:/home/thomasd# hdparm /dev/hdc
> >
> > /dev/hdc:
> >  multcount    = 16 (on)
> >  I/O support  =  0 (default 16-bit)
> 		^^^
>   'hdparm -c1 /dev/hda' to enable 32-bit access - it will be much faster.

did this, but with no success, drive is not becoming faster:
leukertje:/home/thomasd# hdparm -c1 /dev/hdc

/dev/hdc:
 setting 32-bit I/O support flag to 1
 I/O support  =  1 (32-bit)
 leukertje:/home/thomasd# hdparm -t /dev/hdc

dev/hdc:
 Timing buffered disk reads:  64 MB in  5.62 seconds = 11.39 MB/sec
   
Thanks,
thomas
-- 
thomas@deselaers.de «<>» JabberID on request «<>» GPG/PGP key on request
  «< Unless stated otherwise everything I write is just my opinion >»
