Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVBAK7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVBAK7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 05:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVBAK7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 05:59:20 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:1962 "EHLO
	webhosting.rdsbv.ro") by vger.kernel.org with ESMTP id S261983AbVBAK7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 05:59:14 -0500
Date: Tue, 1 Feb 2005 12:59:11 +0200 (EET)
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
X-X-Sender: util@webhosting.rdsbv.ro
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Strange vmstat output. 2.6.10 Scheduler?
In-Reply-To: <20050201104949.GM4137@suse.de>
Message-ID: <Pine.LNX.4.62.0502011258000.26221@webhosting.rdsbv.ro>
References: <Pine.LNX.4.62.0502011217320.26221@webhosting.rdsbv.ro>
 <20050201102638.GJ4137@suse.de> <Pine.LNX.4.62.0502011236100.26221@webhosting.rdsbv.ro>
 <20050201104214.GK4137@suse.de> <Pine.LNX.4.62.0502011243270.26221@webhosting.rdsbv.ro>
 <20050201104949.GM4137@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to say that I disabled HT because I saw an improvement.

Also, the cs seems very high:
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  1  2  12416   6048   7040 816592    0    0     0     0 1299   483  2  1 0 97
  0  2  12416   6016   7040 816592    0    0     0     0 1251   400  3  2 0 95
  0  1  12416   6008   7040 816616    0    0     0    84 1294   409  1  3 0 96
  2  1  12416   5500   7040 817372    0    0  1460     8 1240 11636 61 11 0 28
  0  1  12416   6060   6972 816796    0    0  7620  8420 1260  2327 12  4 0 84
  0  1  12416   6160   6924 816784    0    0  7512   588 1266  1369 16  5 0 79
  0  2  12416   5032   6924 817964    0    0  2964   936 1249  1285 14  4 0 82
  0  3  12416   6176   6992 816628    0    0     0  1552 1256  1187  8  3 0 89
  0  3  12416   6164   6992 816668    0    0     0  1160 1248  1272  7  1 0 92
  0  3  12416   6052   6992 816716    0    0     0   876 1242  1278  8  3 0 89
  0  3  12416   6052   6992 816740    0    0     0  1256 1258  1261  9  2 0 89
  0  3  12416   6028   6992 816772    0    0     0  1264 1266  1388  7  1 0 92
  0  3  12416   5980   6992 816772    0    0     0   616 1236   338  1  1 0 98
  0  4  12416   5028   6996 817900    0    0   844  1472 1250   350  2  2 0 96
  0  4  12416   6064   6996 816700    0    0  6668   700 1256   514  5  2 0 93
  0  3  12416   6180   6996 816532    0    0  3252   164 1237   370 10  2 0 88
  0  3  12416   6116   6996 816532    0    0     0  1120 1267   413  2  2 0 96
  0  2  12416   6116   6996 816532    0    0     0  1240 1275   395  2  1 0 97

It's normal?

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
