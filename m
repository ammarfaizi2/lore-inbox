Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130687AbQLNS57>; Thu, 14 Dec 2000 13:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbQLNS5t>; Thu, 14 Dec 2000 13:57:49 -0500
Received: from callisto.dnx.de ([212.4.162.166]:30115 "EHLO callisto.dnx.de")
	by vger.kernel.org with ESMTP id <S130687AbQLNS5g>;
	Thu, 14 Dec 2000 13:57:36 -0500
Date: Thu, 14 Dec 2000 19:27:07 +0100
From: Lukas Grunwald <lkml@dnx.de>
To: linux-kernel@vger.kernel.org
Subject: test12 RAID5 (buffer.c:765!)
Message-ID: <20001214192707.B20771@callisto.dnx.de>
In-Reply-To: <20001214125243.A8435@sigma07.scs.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001214125243.A8435@sigma07.scs.carleton.ca>; from jemoody@scs.carleton.ca on Thu, Dec 14, 2000 at 12:52:43PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i´ve a problem with 2.4-test12 , after a Setup with RAID5

md0 : active raid5 sdc1[2] sdb1[1] sda1[0]
      8466176 blocks level 5, 16k chunk, algorithm 2 [3/3] [UUU]

after a mke2fs or trying to mount the md0 volume i got a 
kernel BUG at buffer.c:765!
invalid operand: 0000

-- 

Gruss
    Lukas aka lg1
    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
