Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbRGQKbE>; Tue, 17 Jul 2001 06:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265439AbRGQKaz>; Tue, 17 Jul 2001 06:30:55 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:56077 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S265148AbRGQKag>;
	Tue, 17 Jul 2001 06:30:36 -0400
Date: Tue, 17 Jul 2001 12:30:33 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B5413C9.2CE16AC9@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.4.6-ac5
CPU AMD Duron 700

/proc/cpuinfo gives :
cache size: 64 KB

This is wrong :
 - the Duron has 192 kilobytes of cache ( 64 L1 I, 64 L1 D , 64 L2 unified )
 - what is KB ?
   - "kilo" is abbreviated to 'k' , not 'K'
   - "B" means "Bell" :-)

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
