Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSKXNRJ>; Sun, 24 Nov 2002 08:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbSKXNRJ>; Sun, 24 Nov 2002 08:17:09 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:8899 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S261206AbSKXNRI>;
	Sun, 24 Nov 2002 08:17:08 -0500
X-Originating-IP: [62.179.172.61]
From: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>
To: ffmpeg-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Ffmpeg-devel] [RFC] benchmark on athlon + intel xeon + Apple G4 + intel p3
Date: Sun, 24 Nov 2002 13:25:47 +0000
Message-ID: <20021124.ZaY.84260300@mail.pronto.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
X-Mailer: phpGroupWare (http://www.phpgroupware.org) v 0.9.14.000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Intel Pentium III Cu-mine 850MHz (on busy system)
>1.  bench: utime=87.380s
>2.  bench: utime=87.390s
>3.  bench: utime=87.440s
>avg bench: utime=87.403s

humtitim...
trying out on developer.skolelinux.no - a dual P III 997.5MHz (according to /proc/cpuinfo)
machine:

1. bench: utime=75.790s
2. bench: utime=76.570s
3. bench: utime=76.330s
avg. bench: utime=76.230s

>> K7: Hz*s/1000: 76.963
>> G4: Hz*s/1000: 80.223
>> P4: Hz*s/1000: 93.932
>  P3: Hz*s/1000: 74.293
P3(2): Hz*s/1000: 76.094

strange... this shows marginally lower performance on mine than yours, but it still beats the
lot, including the Athlon. Can anyone explain this???????????

I beleive there was some talk on lkml about some sort of P4 optimisation (interrupt stuff) that
wasn't enabled on 2.4, but comes along in 2.5. Any ideas??? (I cc:ed the lkml on this one)

>Hmm, P3 seems pretty fast in comparison and this was not tested on high-end
>system but standard Linux 2.4.18, P3 850, i440BX, 256MB SDRAM, 10GB 4200UPM
>HDD with lots of other apps running at the same time.

The system I was testing on had a load of around 1.2 or something, but given it's a system
with quite nice I/O and two 1GHz CPUs, I don't think it was important.

roy
--
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.


