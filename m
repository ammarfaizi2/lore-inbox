Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUEIXtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUEIXtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUEIXtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 19:49:32 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:48763 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261378AbUEIXt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 19:49:27 -0400
Date: Sun, 9 May 2004 16:51:25 -0700
From: Paul Jackson <pj@sgi.com>
To: Matt Mackall <mpm@selenic.com>
Cc: torvalds@osdl.org, g.liakhovetski@gmx.de, akpm@osdl.org,
       dipankar@in.ibm.com, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: dentry bloat.
Message-Id: <20040509165125.658b2492.pj@sgi.com>
In-Reply-To: <20040509181122.GK5414@waste.org>
References: <Pine.LNX.4.44.0405091058300.2106-100000@poirot.grange>
	<Pine.LNX.4.58.0405090832310.24865@ppc970.osdl.org>
	<20040509181122.GK5414@waste.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyone have stats for such an FS?

Not a samba share but a dual-boot linux box with a few windows file
systems located on various subdirectories of path length 6 to 16 chars.

You have to go to length 67 to get 80% of the names:

length 3, cum 4, percent 0
length 4, cum 17, percent 0
length 5, cum 23, percent 0
length 6, cum 27, percent 0
length 7, cum 49, percent 0
length 8, cum 101, percent 0
length 9, cum 149, percent 0
length 10, cum 223, percent 0
length 11, cum 314, percent 0
length 12, cum 584, percent 0
length 13, cum 876, percent 0
length 14, cum 1321, percent 0
length 15, cum 1726, percent 0
length 16, cum 2289, percent 0
length 17, cum 3004, percent 0
length 18, cum 3618, percent 0
length 19, cum 4282, percent 0
length 20, cum 5024, percent 0
length 21, cum 6059, percent 1
length 22, cum 7114, percent 1
length 23, cum 8323, percent 1
length 24, cum 9885, percent 1
length 25, cum 11786, percent 1
length 26, cum 14184, percent 2
length 27, cum 16704, percent 2
length 28, cum 19470, percent 3
length 29, cum 23400, percent 3
length 30, cum 28310, percent 4
length 31, cum 35104, percent 5
length 32, cum 40083, percent 6
length 33, cum 46084, percent 7
length 34, cum 52765, percent 8
length 35, cum 59267, percent 9
length 36, cum 66206, percent 11
length 37, cum 73745, percent 12
length 38, cum 82686, percent 13
length 39, cum 93252, percent 15
length 40, cum 105353, percent 17
length 41, cum 118474, percent 19
length 42, cum 130596, percent 22
length 43, cum 143802, percent 24
length 44, cum 156347, percent 26
length 45, cum 169459, percent 28
length 46, cum 184349, percent 31
length 47, cum 199955, percent 33
length 48, cum 215665, percent 36
length 49, cum 232193, percent 39
length 50, cum 248706, percent 41
length 51, cum 263703, percent 44
length 52, cum 278759, percent 47
length 53, cum 294684, percent 49
length 54, cum 310449, percent 52
length 55, cum 326860, percent 55
length 56, cum 343146, percent 57
length 57, cum 359223, percent 60
length 58, cum 375097, percent 63
length 59, cum 389867, percent 65
length 60, cum 409873, percent 69
length 61, cum 421748, percent 71
length 62, cum 433091, percent 73
length 63, cum 443854, percent 74
length 64, cum 454093, percent 76
length 65, cum 463521, percent 78
length 66, cum 472333, percent 79
length 67, cum 480730, percent 81
length 68, cum 488440, percent 82
length 69, cum 494620, percent 83
length 70, cum 500712, percent 84
length 71, cum 506007, percent 85
length 72, cum 510948, percent 86
length 73, cum 515491, percent 86
length 74, cum 520553, percent 87
length 75, cum 524475, percent 88
length 76, cum 528410, percent 89
length 77, cum 532247, percent 89
length 78, cum 535946, percent 90
length 79, cum 539595, percent 90
length 80, cum 543056, percent 91
length 81, cum 546411, percent 92
length 82, cum 549284, percent 92
length 83, cum 552563, percent 93
length 84, cum 555361, percent 93
length 85, cum 558000, percent 94
length 86, cum 560718, percent 94
length 87, cum 563665, percent 95
length 88, cum 566046, percent 95
length 89, cum 568362, percent 95
length 90, cum 570559, percent 96
length 91, cum 572596, percent 96
length 92, cum 574224, percent 96
length 93, cum 575820, percent 97
length 94, cum 577350, percent 97
length 95, cum 578693, percent 97
length 96, cum 580016, percent 97
length 97, cum 581175, percent 98
length 98, cum 582349, percent 98
length 99, cum 583471, percent 98
length 100, cum 584385, percent 98
length 101, cum 585189, percent 98
length 102, cum 585926, percent 98
length 103, cum 586489, percent 98
length 104, cum 587178, percent 99
length 105, cum 587746, percent 99
length 106, cum 588257, percent 99
length 107, cum 588664, percent 99
length 108, cum 589181, percent 99
length 109, cum 589491, percent 99


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
