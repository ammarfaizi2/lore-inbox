Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311718AbSCNSdh>; Thu, 14 Mar 2002 13:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311720AbSCNSd1>; Thu, 14 Mar 2002 13:33:27 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:33648 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S311718AbSCNSdV>; Thu, 14 Mar 2002 13:33:21 -0500
Message-ID: <3C90ECDF.8EBC8FD4@ngforever.de>
Date: Thu, 14 Mar 2002 11:33:03 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Martin Eriksson <nitrax@giron.wox.org>
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Eriksson wrote:

> What is "best" on Linux 2.4.X (with any appropriate patches) ?
> 
> HPT370 RAID-1 or Software RAID-1 ?
> 
> And if Software RAID-1 is best of these two, where is it most stable; on an
> i815 chipset, a VIA chipset (686B) or on a promise controller?
> 
> I define "best" as:
> * most stable
> * least complex setup
> * least hassle when something goes wrong

Software RAID is just your disk configuration. But I'd recommend
hardware raid because the rebuild after one disk crash is dog slow with
software raid. This problem been discussed in all possible linux
magazines...
I prefer SCSI RAID5

Thunder
-- 
begin-base64 755 -
IyEgL3Vzci9iaW4vcGVybApteSAgICAgJHNheWluZyA9CSMgVGhlIHNjcmlw
dCBvbiB0aGUgbGVmdCBpcyB0aGUgcHJvb2YKIk5lbmEgaXN0IGVpbiIgLgkj
IHRoYXQgaXQgaXNuJ3QgYWxsIHRoZSB3YXkgaXQgc2VlbXMKIiB2ZXJhbHRl
dGVyICIgLgkjIHRvIGJlIChlc3BlY2lhbGx5IG5vdCB3aXRoIG1lKQoiTkRX
LVN0YXIuXG4iICA7CiRzYXlpbmcgPX4Kcy9ORFctU3Rhci9rYW5uXAogdW5z
IHJldHRlbi9nICA7CiRzYXlpbmcgICAgICAgPX4Kcy92ZXJhbHRldGVyL2Rp
XAplIExpZWJlL2c7CiRzYXlpbmcgPX5zL2Vpbi8KbnVyL2c7JHNheWluZyA9
fgpzL2lzdC9zYWd0LC9nICA7CiRzYXlpbmc9fnMvXG4vL2cKO3ByaW50Zigk
c2F5aW5nKQo7cHJpbnRmKCJcbiIpOwo=
====
Extract this and see what will happen if you execute my
signature. Just save it to file and do a
> uudecode $file | perl
