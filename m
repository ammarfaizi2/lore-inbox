Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318821AbSG0UrR>; Sat, 27 Jul 2002 16:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318822AbSG0UrR>; Sat, 27 Jul 2002 16:47:17 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12046 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318821AbSG0UrQ>; Sat, 27 Jul 2002 16:47:16 -0400
Date: Sat, 27 Jul 2002 17:50:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Buddy Lumpkin <b.lumpkin@attbi.com>
cc: Ville Herva <vherva@niksula.hut.fi>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
In-Reply-To: <FJEIKLCALBJLPMEOOMECGEPDCPAA.b.lumpkin@attbi.com>
Message-ID: <Pine.LNX.4.44L.0207271748060.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002, Buddy Lumpkin wrote:

> >Much more.
> >
> >The latency difference seems to be on the order of 100000 times.
> >It is the latency we care about because that determines how long
> >the CPU cannot do anything useful but has to wait.
>
> And if you look at the ratio between the access time of ram which is in
> the low nanoseconds (1* 10 ^ -9) ... and compare it to the seek +
> rotational delay of a discrete spindal which is in low milliseconds (1*
> 10 ^ -3) that puts you at a ratio of about 1000000.

Indeed.

Now imagine one in every million memory accesses results in
a major page fault ... your computer would run at 1/2 speed.

The difference between a 99.999% hit rate and 99.9999% hit
rate becomes rather important with these latency ratios ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

