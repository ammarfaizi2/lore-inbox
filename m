Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277039AbRJHRsa>; Mon, 8 Oct 2001 13:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277034AbRJHRsW>; Mon, 8 Oct 2001 13:48:22 -0400
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:17427 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S277039AbRJHRsI>; Mon, 8 Oct 2001 13:48:08 -0400
Message-ID: <3BC1E68E.3010805@zk3.dec.com>
Date: Mon, 08 Oct 2001 13:46:54 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: More 2.4.9 vs. 2.4.10 numbers
Content-Type: multipart/mixed;
 boundary="------------080503060208020806080008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080503060208020806080008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

	As reminded by a few, the numbers I sent a few days ago about AIM VII 
performance on my NUMA Alpha system didn't include any numbers for -ac 
series kernels.  I'm attaching some numbers for 2.4.9-ac18 and 
2.4.10-ac4, as well as a run under 2.4.10 with XFS for those interested 
souls. :)  Again, let me know if there are more runs people would like 
to see.  I'm working on fixing the problems with SMP Alpha boxen in the 
2.4.11-pre series, but I can always work around that in a way that won't 
affect performance if there are interesting tests requested. :)

  - Pete

--------------080503060208020806080008
Content-Type: text/plain;
 name="suite7.ss.new"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="suite7.ss.new"

2.4.9-ac18
----------
Benchmark	Version	Machine	Run Date
AIM Multiuser Benchmark - Suite VII	"1.0"	sundown2	Oct  4 20:13:13 2001
Tasks	Jobs/Min	JTI	Real	CPU	J/S/T	user	sys	idle/wait
1	40.3		100	144.5	12.4	0.6714	1.4	18.6	1135.8
500	5594.3		95	520.2	3625.1	0.1865	671.0	2964.7	525.7
1000	3795.7		95	1533.3	8396.4	0.0633	1350.5	7061.8	3854.1
1500	3091.2		96	2824.1	13848.9	0.0343	2023.2	11860.2	8709.6
2000	3386.5		93	3437.2	17109.4	0.0282	2689.7	14453.5	10354.5
2500	1936.2		94	7514.6	24541.2	0.0129	3377.4	21239.9	35499.2

2.4.10-ac4
----------
Benchmark	Version	Machine	Run Date
AIM Multiuser Benchmark - Suite VII	"1.0"	sundown2	Oct  5 09:48:57 2001
Tasks	Jobs/Min	JTI	Real	CPU	J/S/T	user	sys	idle/wait
1	39.6		100	146.8	14.5	0.6606	1.4	22.4	1150.9
500	5298.2		95	549.2	3664.4	0.1766	670.4	3004.3	719.3
1000	4187.6		95	1389.8	8047.9	0.0698	1343.1	6723.4	3052.1
1500	2511.4		97	3476.1	15162.5	0.0279	2028.6	13170.9	12609.6
2000	2165.3		94	5375.6	19933.2	0.0180	2699.6	17277.8	23027.2
2500	2359.8		94	6165.8	23834.3	0.0157	3361.4	20525.6	25439.9

2.4.10-xfs
----------
Benchmark	Version	Machine	Run Date
AIM Multiuser Benchmark - Suite VII	"1.0"	sundown2	Oct  5 18:45:19 2001
Tasks	Jobs/Min	JTI	Real	CPU	J/S/T	user	sys	idle/wait
1	20.1		100	289.7	6.4	0.3348	1.3	7.8	2308.4
500	7773.6		97	374.3	2272.2	0.2591	683.2	1596.8	714.8
1000	4381.0		98	1328.5	6303.4	0.0730	1376.2	4949.5	4301.9
1500	2569.6		99	3397.4	11772.5	0.0286	2073.5	9823.2	15282.6
2000	1744.3		97	6673.0	20191.0	0.0145	2749.8	17515.0	33119.3

--------------080503060208020806080008--

