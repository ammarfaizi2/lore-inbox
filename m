Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTH3NZN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTH3NZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:25:13 -0400
Received: from dyn-ctb-210-9-241-196.webone.com.au ([210.9.241.196]:4612 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263679AbTH3NZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:25:01 -0400
Message-ID: <3F50A5A2.8070107@cyberone.com.au>
Date: Sat, 30 Aug 2003 23:24:50 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Gabor MICSKO <gmicsko@szintezis.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [FS Benchmark] reiser4 vs. reiserfs (3.6)
References: <1062233153.499.15.camel@sunshine>
In-Reply-To: <1062233153.499.15.camel@sunshine>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gabor MICSKO wrote:

>Kernel: 2.6.0-test4 SMP
>
>
Hi Gabor,
Just a suggestion, comparisons like this are often nicer to read if they
are in a patch format. It also saves you having to do anything by hand.

--- ReiserFS3   2003-08-30 23:15:35.000000000 +1000
+++ ReiserFS4   2003-08-30 23:15:52.000000000 +1000
@@ -1,57 +1,57 @@
-1062096658
+1062095831
                                                                                                                                                            

 ## Create files
                                                                                                                                                            

-Total create files: 19491
-00004c6f: No space left on device
+Total create files: 18858
+000049f3: No space left on device
 Create files
                                                                                                                                                            

-real 1m11.586s
-user 0m0.085s
-sys 0m6.181s
+real 1m7.309s
+user 0m0.141s
+sys 0m9.571s
                                                                                                                                                            

 ## tar all
                                                                                                                                                            

 ## Change owner
                                                                                                                                                            

-real 0m1.583s
-user 0m0.010s
-sys 0m0.145s
+real 0m1.597s
+user 0m0.021s
+sys 0m0.209s
                                                                                                                                                            

 ## random access
-Success: 19477
-Fail: 90
+Success: 18858
+Fail: 72
                                                                                                                                                            

-real 5m56.516s
-user 0m0.230s
-sys 0m4.311s
+real 4m27.653s
+user 0m0.292s
+sys 0m6.247s
                                                                                                                                                            

 ## Change mode
                                                                                                                                                            

-real 0m0.820s
-user 0m0.019s
-sys 0m0.227s
+real 0m4.103s
+user 0m0.033s
+sys 0m0.436s
                                                                                                                                                            

 ## Random delete and create
-Total create files: 8612
-Total delete files: 8700
-Total error : 2255
-
-real 1m33.936s
-user 0m0.085s
-sys 0m4.342s
+Total create files: 8271
+Total delete files: 8393
+Total error : 2266
+
+real 2m7.920s
+user 0m0.123s
+sys 0m6.025s
                                                                                                                                                            

 ## Change mode again
                                                                                                                                                            

-real 0m0.229s
-user 0m0.010s
-sys 0m0.136s
+real 0m0.438s
+user 0m0.026s
+sys 0m0.243s
                                                                                                                                                            

 ## Remove all files and directories
                                                                                                                                                            

-real 0m21.887s
-user 0m0.014s
-sys 0m1.251s
+real 0m1.299s
+user 0m0.029s
+sys 0m1.178s
                                                                                                                                                            

 ## Finish test
-1062097334
+1062096367


