Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRKVKPi>; Thu, 22 Nov 2001 05:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRKVKP3>; Thu, 22 Nov 2001 05:15:29 -0500
Received: from [62.245.135.174] ([62.245.135.174]:45442 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S275743AbRKVKPM>;
	Thu, 22 Nov 2001 05:15:12 -0500
Message-ID: <3BFCD029.DAED8BF7@TeraPort.de>
Date: Thu, 22 Nov 2001 11:15:05 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: mjustice@boxxtech.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        S.Akhtary@TeraPort.de
Subject: Re: Tuning Linux for high-speed disk subsystems
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 11/22/2001 11:15:04 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 11/22/2001 11:15:11 AM,
	Serialize complete at 11/22/2001 11:15:11 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: Tuning Linux for high-speed disk subsystems
> 
> 
> > As I count your disks may be the double for the best case. I read here on
> > LKML a post that someone claims that W2k deliever 250 MB/s with such a
> > configuration. Linux 2.4 should do the same. Ask the SCSI gurus.
> >
> 
> That may have been my post you refer to. With 2x5 disks, each capable of
> 50 MB/s by itself, we can stream 255 MB/s very smoothly in either direction
> with W2K --- as long as FILE_FLAG_NOBUFFER is used. With standard
> reads the number is more like 100 MB/s if I recall correctly, so the buffer
> cache can definitely get in the way.
> 
> With Linux + XFS I was getting 250 MB/s read and 220 MB/s write (with a
> bit less smoothness than W2K) using O_DIRECT and no high mem to avoid
> bounce buffer copies. Using standard reads the numbers drop to around
> 120 MB/s. That was a couple of weeks ago and I want to try tweaking some
> more but a co-worker has "borrowed" pieces of the hardware for the moment.
> 
Marvin,

 could you elaborate a bit more :-), or point me/us to your post
(couldn't find it). We are currently evaluating solutions for doing HDTV
playback for one of our customers. This will need about 300-320 MB/sec
read. We know (at least someone claims so) that you can do it with SGI
equipment at a price. The goal for the customer is to definitely beat
that price :-))

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
