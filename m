Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273487AbRI3NHL>; Sun, 30 Sep 2001 09:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273474AbRI3NHB>; Sun, 30 Sep 2001 09:07:01 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:56252 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S273470AbRI3NGn>;
	Sun, 30 Sep 2001 09:06:43 -0400
Date: Sun, 30 Sep 2001 15:07:09 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Difference of perfs between 2.4.0 + ext3 and 2.4.9-ac17
Message-ID: <20010930150709.A18002@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm submitting a machine to four runs of kernel+modules compile under
MAKE="make -j4" (the same kernel each time). Machine is a bi-PII 350, 
384Mo ram.
Swap:
787384k (priority -1) (raid1 over scsi)
95164k (priority -2) (raid1 over ide)

2.4.10-ext3:
real    103m39.305s	103m37.916s	103m49.334s	105m17.045s
user    97m9.060s	97m10.450s	97m9.300s	97m9.550s	
sys     4m4.900s	4m3.590s	4m5.670s	4m7.050s

2.4.9-ac17:
real    53m25.069s	53m11.890s	53m7.808s	53m24.110s
user    97m42.970s	97m41.280s	97m43.270s	97m40.650s
sys     5m2.130s	5m1.090s	4m57.440s	5m1.520s

Some graphs from vmstat 1 output are available at
http://www.cogenit.fr/linux/bench/2.4.9-ac17/
http://www.cogenit.fr/linux/bench/2.4.10-ext3/img/

Only the first two runs are available for 2.4.10-ext3 (I lused on vmstat 
output file, test is about to be reissued).

-- 
Ueimor
