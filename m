Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271892AbTHHUnu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271898AbTHHUnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:43:50 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:10981 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S271892AbTHHUns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:43:48 -0400
Message-ID: <3F340B7F.6000505@mrs.umn.edu>
Date: Fri, 08 Aug 2003 15:43:43 -0500
From: Grant Miner <mine0057@mrs.umn.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: reiserfs-list@namesys.com
Subject: Filesystem Benchmarking script w ext2
Content-Type: multipart/mixed;
 boundary="------------030304090906070400060603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030304090906070400060603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Some people asked about ext2 so it is in this sample results.

It seemes like there was some interest in the filesystem benchmarks, so 
I have written a better testing script.  Take it from 
http://umn.edu/~mine0057/bench .
(You will need scsh to use it.)

It makes it easy to select which filesytems to benchmark, and you get a 
tab-delimited output (so you can import into Excel :).  Also, you can 
customize the list of tests with whatever commands you wish.  If anyone 
finds it useful, let me know so that I continue to work on it.  Attached 
is a sample output.

--------------030304090906070400060603
Content-Type: text/plain;
 name="results2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="results2.txt"

fs	bigdir	cpu 	cp	cpu 	cp2	cpu 	cp3	cpu 	cp4	cpu 	cp5	cpu 	rm	cpu 	rm2	cpu 	rm3	cpu 	sync	cpu 	total	avg
ext2	33.01	0.235989	37.82	0.149656	43.81	0.128281	44.14	0.127096	46.09	0.121284	49.75	0.115779	15.95	0.0376176	7.66	0.0861619	15.2	0.0427632	0.43	0.	293.86	0.129109
ext3	38.47	0.248505	94.42	0.0775259	61.35	0.119478	62.64	0.117976	62.58	0.119367	64.7	0.117156	25.14	0.0640414	7.86	0.194656	13.17	0.118451	4.94	0.00202429	435.27	0.117996
reiser4	32.95	0.32868	33.27	0.326721	32.31	0.341071	34.48	0.327726	33.88	0.332054	31.	0.36871	17.51	0.262707	7.74	0.527132	12.97	0.341557	0.55	0.	236.66	0.337235

--------------030304090906070400060603--

