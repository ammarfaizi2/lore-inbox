Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWAQSYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWAQSYa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWAQSYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:24:30 -0500
Received: from lucidpixels.com ([66.45.37.187]:24504 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932311AbWAQSY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:24:29 -0500
Date: Tue, 17 Jan 2006 13:24:27 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <1137521483.14135.59.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0601171324010.25508@p34>
References: <Pine.LNX.4.64.0601161957300.16829@p34>  <20060117012319.GA22161@linuxace.com>
  <Pine.LNX.4.64.0601162031220.2501@p34>  <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
 <1137521483.14135.59.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-1165306728-1137522267=:25508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-1165306728-1137522267=:25508
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Alan, is it normal for FTP to be 2x as fast as NFS?
With 100mbps, I never seemed to have any issues, but with GIGABIT I=20
definitely see all sorts of weird issues.


On Tue, 17 Jan 2006, Alan Cox wrote:

> On Maw, 2006-01-17 at 18:48 +0100, Tomasz K=C5=82oczko wrote:
>>> I wonder how much faster NFS over TCP would be, or if NFS in the kernel=
 is
>>> the problem itself?
>>
>> On Linux NFS over TCP is slower than over UDP ~10%.
>
> For the specific case you measured. Its never quite that simple because
> behaviour over different networks and error patterns varies a lot and
> TCP can be a big win on loaded networks or under error conditions,
> especially packet loss, where fragmentation losses kill throughput on
> UDP.
>
>
---1463747160-1165306728-1137522267=:25508--
