Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292981AbSCIXsK>; Sat, 9 Mar 2002 18:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292982AbSCIXsB>; Sat, 9 Mar 2002 18:48:01 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:9569 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S292981AbSCIXrz>; Sat, 9 Mar 2002 18:47:55 -0500
Message-ID: <3C8A9ECF.F8BB8575@ngforever.de>
Date: Sat, 09 Mar 2002 16:46:23 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
CC: linux-kernel@vger.kernel.org, nakasei@fa.mdis.co.jp
Subject: Re: 2.2.21-pre4 hung up
In-Reply-To: <200203092312.AA00022@prism.kumin.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seiichi Nakashima wrote:
> 
> Hi.
> 
> I update to linux-2.2.20 + patch-2.2.21-pre4.
> before I used linux-2.2.20 + patch-2.2.21-pre3, and worked fine.
> linux-2.2.21-pre4 is normal end to patch, compile and install, but bootup failuer.
> 
> these messages displayed on console, and hung up.
> 
> ===== messaged start =====
> Uncompressing Linux... Ok, booting the kernel.
> Linux version 2.2.21pre4 (root@homesv) (gcc version 2.95.3 20010315 (release)) #
> 1 Sun Mar 10 07:31:33 JST 2002
> USER-provided physical RAM map:
>  USER: 000a0000 @ 00000000 (usable)
>  USER: 05efd000 @ 00100000 (usable)
> Detected 400916 kHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 799.53 BogoMIPS
> Memory: 95824k/98292k abailable (816k kernel code, 412k reserved, 1180k data, 60k init)
> Dentry hash table entries: 16384 (order 5, 128k)
> Buffer cache hash table entries: 131072 (order 7, 512k)
> Page cache hash table entries: 32768 (order 5, 128k)
> CPU: L1 I cache: 16K, L1 D cache: 16K
> Intel machine check architecture supported.
> ===== messages end =====

I remember this was the one-and-zero stuff from last evening or
whenever. Can someone remember? It was just some 0 which had to be 1.
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
