Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbTFYUhp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTFYUhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:37:45 -0400
Received: from h24-70-162-27.wp.shawcable.net ([24.70.162.27]:42178 "EHLO ubb")
	by vger.kernel.org with ESMTP id S265053AbTFYUf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:35:27 -0400
Message-Id: <v04003a45bb1fb9f4ce1b@[192.168.1.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Organisation: Judean People's Front; Department of Whips, Chains, Thumb-Screws, Six Tons of Whipping Cream, the Entire Soprano Section of the Mormon Tabernacle Choir and Guest Apperances of Eva Peron aka Eric Conspiracy Secret Laboratories
X-Disclaimer-1: This message has been edited from it's original form by members of the Eric Conspiracy.
X-Disclaimer-2: There is no Eric Conspiracy.
X-Not-For-Humans: aardvark@apia.dhs.org and zebra@apia.dhs.org are spamtraps.
Date: Wed, 25 Jun 2003 15:49:18 -0500
To: linux-kernel@vger.kernel.org
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Disk performance irregularity in 2.4.x -- another trace
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To follow up on my previous message, I just caught another instance of my
disk performance irregularity with vmstat. This time the system was
basically "idle".

This trace doesn't show any context switch oddities, so I suspect it was
just some spurious process doing something weird on the last trace.

 2  0  83852   4944  40808 180220    0    0     0     0  283   268 53 14 33  0
 1  0  83852   4920  40808 180220    0    0     0     0  238   286 44 11 45  0
 0  0  83852   4656  40816 180220    0    0     0    16  233   309 21 15 64  0
 0  0  83852   4496  40832 180348    0    0   128    76  290   299 30 13 57  0
 0  0  83852   4508  40840 180348    0    0     0    16  258   305 23 13 64  0
 0  0  83852   4340  40728 180140    0    0    16    36  233   343 15 15 70  0
 0  0  83852   5896  40452 179932    0    0    45    96  359   383 28 19 52  0
 0  0  83852   5864  40480 179932    0    0     0   195  351   341 11 15 74  0
 0  0  83852   5872  40480 179932    0    0     0     0  231   283 18  8 73  0
 1  0  83852   5820  40488 179932   32    0    40     0  277   276 26 12 62  0
 0  0  83852   5804  40488 179948    0    0    16     0  297   307 16 15 69  0
 0  0  83852   5780  40512 179948    0    0     0    76  224   282 11  9 80  0
 3  0  83852   5796  40512 179948    0    0     0     0  282   273 29 11 60  0
 0  0  83852   5768  40512 179948    0    0     0     0  229   252 16 11 73  0
 0  0  83852   5768  40512 179948    0    0     0     0  210   267  9 10 81  0
 3  0  83852   5704  40512 179948    0    0     0     0 1278   545 53 30 17  0
 3  0  83852   5700  40528 179948    0    0     0    44 2035   926 45 33 22  0
 2  0  83852   5672  40528 179948   12    0    12     0 1304   700 27 32 40  0
 2  0  83852   5636  40528 179948   32    0    32     0 1150   585 41 26 33  0
 0  0  83852   5496  40552 180056    0    0   112   172  471   435 16 15 69  0
 0  2  83852   4964  40552 180412    0    0   356   532  297   307  8  8 84  0
 0  3  83852   4968  40556 180412    0    0     4  1004  330   312  8  8 84  0
 0  3  83852   4960  40556 180412    0    0     0  1056  404   319  9  9 83  0
 0  4  83852   4964  40556 180412    0    0     0   868  316   285 10  8 82  0
 0  4  83852   4936  40580 180412    0    0     4   784  476   391 10 11 79  0
 0  4  83852   4692  40580 180416    0    0     0   892  327   326  8 10 82  0
 1  4  83852   4644  40580 180416    0    0     0  1208  340   323 56  9 36  0
 0  5  83852   4628  40580 180416    0    0     0  1072  389   346 12 14 74  0
 0  5  83852   4348  40600 180416    0    0     0  1496  403   360 11 10 79  0
 0  6  83852   4460  40560 180328    0    0     0  1064  481   365 10 11 78  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 3  0  83852   4340  40456 180432    0    0   256   652  320   350 53  9 38  0
 5  0  83852   4708  40344 180448    0    0     0   336  222   301 46 13 42  0
 0  0  83852   4500  40384 180448    0    0     0   190  298   323 26 15 59  0
 0  0  83852   4484  40384 180448    0    0     0     0  229   291 22  6 72  0
 3  0  83852   4664  40236 180420    0    0    44     0  308   324 30 12 58  0
 0  0  83852   5404  40252 180384    0    0     8    16  262   305 20 11 69  0
 0  0  83852   5368  40288 180384    0    0     0   249  239   299  9 12 79  0
 1  0  83852   5360  40288 180400    0    0    16     0  254   278 23 15 62  0
 1  0  83852   5332  40288 180428    0    0    28     0  302   296 32 10 59  0
 0  0  83852   5272  40288 180480    0    0    52     0  280   317 16 11 73  0
 0  0  83852   5172  40296 180580    0    0   100    44  261   281 19 12 68  0
 0  0  83852   5028  40304 180580    0    0     0     0  254   294 19 12 69  0
 1  0  83852   4728  40304 180712    0    0   128     0  236   286 41  7 52  0
 2  0  83852   4728  40304 180712    0    0     0     0  315   286 64 12 24  0
 0  0  83852   4852  40108 180532    0    0     0    16  259   325 22 17 61  0


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


