Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276226AbRI1SX2>; Fri, 28 Sep 2001 14:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276225AbRI1SXI>; Fri, 28 Sep 2001 14:23:08 -0400
Received: from elin.scali.no ([62.70.89.10]:44560 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S276221AbRI1SW5>;
	Fri, 28 Sep 2001 14:22:57 -0400
Message-ID: <3BB4BF1F.B333625B@scali.no>
Date: Fri, 28 Sep 2001 20:19:11 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: mm: critical shortage of bounce buffers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list members,

I've recently encountered the following message on a machine running RedHat's
2.4.3-12 kernel :

"mm: critical shortage of bounce buffers"

I've searched through the kernel sources, but my 'find' just can't locate this
string anywhere.

Why does this message appear (apparently during high network load with the intel
eepro100 driver or e1000 driver). Is bounce buffers really in use on a x86
machine with 2GB of RAM (normal smp RedHat kernel, not enterprise)??

I appreciate any feedback.


Thanks,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
