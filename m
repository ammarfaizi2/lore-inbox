Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262434AbSJPMMc>; Wed, 16 Oct 2002 08:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSJPMMc>; Wed, 16 Oct 2002 08:12:32 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:38329 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262434AbSJPML1>; Wed, 16 Oct 2002 08:11:27 -0400
Message-ID: <04fd01c2750d$c895a470$690b720a@M3104487>
From: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCH MARK] 'tiobench' results comparision for 2.5.43 kernel and 2.4.19
Date: Wed, 16 Oct 2002 17:45:57 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-01a15ab3-e948-4792-aef8-860340a3207b"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-01a15ab3-e948-4792-aef8-860340a3207b
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hai...
    Here is the benchmark results of tiobench for 2.5.43 kernel and 2.4.19
kernel. There is a  drastic performance degradation in Read operations of
2.5.43 kernel as compared to 2.4.19 kernel though there is a little
improvement in write operations. Any cooments..?

Details of Test Machine:
=================
Hardware: 400Mhz  Celeron with 64Mb Ram with ext2 file system.

************************************************************************
linux-2.5.43
Tiotest results for 4 concurrent io threads:
,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
+-----------------------+----------+--------------+----------+---------+
| Write          40 MBs |    8.9 s |   4.509 MB/s |   0.4 %  |   6.2 % |
| Random Write   16 MBs |   19.5 s |   0.802 MB/s |   0.0 %  |   1.4 % |
| Read           40 MBs |    7.9 s |   5.090 MB/s |   0.3 %  |   4.9 % |
| Random Read    16 MBs |   37.3 s |   0.419 MB/s |   0.1 %  |   1.2 % |
`----------------------------------------------------------------------'
Tiotest latency results:
,-------------------------------------------------------------------------.
| Item         | Average latency | Maximum latency | % >2 sec | % >10 sec |
+--------------+-----------------+-----------------+----------+-----------+
| Write        |        2.144 ms |     3340.874 ms |  0.02930 |   0.00000 |
| Random Write |        7.420 ms |     8241.095 ms |  0.10000 |   0.00000 |
| Read         |        2.526 ms |      534.798 ms |  0.00000 |   0.00000 |
| Random Read  |       35.709 ms |      131.234 ms |  0.00000 |   0.00000 |
|--------------+-----------------+-----------------+----------+-----------|
| Total        |        7.737 ms |     8241.095 ms |  0.02458 |   0.00000 |
`--------------+-----------------+-----------------+----------+-----------'


*********************************************************************
linux-2.4.19
Tiotest results for 4 concurrent io threads:
,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
+-----------------------+----------+--------------+----------+---------+
| Write          40 MBs |    9.7 s |   4.135 MB/s |   0.3 %  |   3.9 % |
| Random Write   16 MBs |   27.3 s |   0.573 MB/s |   0.0 %  |   0.4 % |
| Read           40 MBs |    1.7 s |  23.597 MB/s |   0.6 %  |  14.2 % |
| Random Read    16 MBs |    4.0 s |   3.879 MB/s |   0.7 %  |   4.5 % |
`----------------------------------------------------------------------'
Tiotest latency results:
,-------------------------------------------------------------------------.
| Item         | Average latency | Maximum latency | % >2 sec | % >10 sec |
+--------------+-----------------+-----------------+----------+-----------+
| Write        |        0.618 ms |     1449.211 ms |  0.00000 |   0.00000 |
| Random Write |        0.100 ms |       61.018 ms |  0.00000 |   0.00000 |
| Read         |        0.158 ms |       59.913 ms |  0.00000 |   0.00000 |
| Random Read  |        1.561 ms |      484.705 ms |  0.00000 |   0.00000 |
|--------------+-----------------+-----------------+----------+-----------|
| Total        |        0.512 ms |     1449.211 ms |  0.00000 |   0.00000 |
`--------------+-----------------+-----------------+----------+-----------'


Rgds,
Siva



------=_NextPartTM-000-01a15ab3-e948-4792-aef8-860340a3207b
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-01a15ab3-e948-4792-aef8-860340a3207b--
