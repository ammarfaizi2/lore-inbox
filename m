Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135222AbRDRRV0>; Wed, 18 Apr 2001 13:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135224AbRDRRVQ>; Wed, 18 Apr 2001 13:21:16 -0400
Received: from chiara.elte.hu ([157.181.150.200]:2314 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135222AbRDRRVG>;
	Wed, 18 Apr 2001 13:21:06 -0400
Date: Wed, 18 Apr 2001 18:19:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: Zach Brown <zab@zabbo.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: numbers?
In-Reply-To: <3ABBB0EF.7A292060@chromium.com>
Message-ID: <Pine.LNX.4.30.0104181807480.29999-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Mar 2001, Fabio Riccardi wrote:

> I'm building an alternative web server that is entirely in _user
> space_ and that achieves the same level of performance as TUX.
> Presently I can match TUX performance within 10-20%, and I still have
> quite a few improvements in my pocket.

very interesting statement, which appears to be contradicted by numbers on
your website. Your website says you get a 1375 SPECweb99 connections
result on a dual 1 GHz, 4 GB, PIII system:

	http://www.chromium.com/cr_hp.html

the best TUX 2.0 result published so far, on a very similar system (same
CPU speed, same amount of RAM, same number and type of network cards) is
3222 connections:

        http://www.spec.org/osg/web99/results/res2001q2/web99-20010319-00100.html

the difference between 1375 and 3222 is quite substantial, TUX is 134%
faster (2.3 times the performance of your server). I'm sure a userspace
webserver can get quite close to TUX in simple static benchmarks (in fact
phttpd should be very close), but SPECweb99 is far from simple. When
saying you are 10-20% close to TUX, did you refer to SPECweb99 results?

	Ingo

