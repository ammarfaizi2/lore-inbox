Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292491AbSCDQa3>; Mon, 4 Mar 2002 11:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292481AbSCDQaL>; Mon, 4 Mar 2002 11:30:11 -0500
Received: from elin.scali.no ([62.70.89.10]:6673 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S292476AbSCDQaD>;
	Mon, 4 Mar 2002 11:30:03 -0500
Date: Mon, 4 Mar 2002 17:29:58 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
To: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
        <jgarzik@mandrakesoft.com>, <linux-net@vger.kernel.org>
Subject: Re: [BETA-0.94] Fifth test release of Tigon3 driver
In-Reply-To: <20020304164453.A27587@stud.ntnu.no>
Message-ID: <Pine.LNX.4.30.0203041724330.11390-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Thomas Langås wrote:

> David S. Miller:
> > How does this thing perform for people?  In particular lmbench
> > 'bw_tcp' and 'lat_tcp' numbers over gigabit on beefy hardware are
> > considered very interesting...
>
> Ok, here I am again; doing some benchmarking :)
>
> (all this is done with same hardware as before, and your tg3 v0.94 driver in
> both ends):
> test8:/usr/src/LMbench/bin/i686-pc-linux-gnu# ./bw_tcp 129.241.56.160
> initial bandwidth measurement: move=10485760, usecs=117352: 89.35 MB/sec
> move=693633024, XFERSIZE=65536
> Socket bandwidth using 129.241.56.160: 104.73 MB/sec
>

Hi guys,

Excuse me for beeing off topic here, but I'm running the LMbench TCP test
on a ethernet emulation driver I've written for SCI, and I can't seem to
get the correct numbers. This is what I get :

sci3:/root# ./bw_tcp sci4
initial bandwidth measurement: move=10485760, usecs=60059: 174.59 MB/sec
move=1365245952, XFERSIZE=65536
Socket bandwidth using sci4: 371.53 MB/sec

The initial measurement seems ok (based on the chipset and so on), but the
last one is _way_ too high. Can it be that the bw_tcp test measures it
wrongly ? Maybe this is a case for the LMbench maintainer...


Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

