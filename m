Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284013AbRLAI76>; Sat, 1 Dec 2001 03:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284014AbRLAI7s>; Sat, 1 Dec 2001 03:59:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49669 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284013AbRLAI7g>; Sat, 1 Dec 2001 03:59:36 -0500
Message-ID: <3C089BDB.4020801@zytor.com>
Date: Sat, 01 Dec 2001 00:59:07 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Incremental prepatches
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have created a robot on kernel.org which makes incremental prepatches 
available.  It looks for standard-named prepatches in the 
/pub/linux/kernel/v*.*/testing directories, and creates incrementals in 
the corresponding /pub/linux/kernel/v*.*/testing/incr directory.

For example:

hera 86 % cd /pub/linux/kernel/v2.5/testing/incr/
hera 87 % ls -l *.gz
-rw-rw-r--    1 kdist    kernel     177158 Nov 27 10:17 
patch-2.5.1-pre1-pre2.gz
-rw-rw-r--    1 kdist    kernel     102202 Nov 28 15:35 
patch-2.5.1-pre2-pre3.gz
-rw-rw-r--    1 kdist    kernel      52955 Nov 29 15:29 
patch-2.5.1-pre3-pre4.gz
-rw-rw-r--    1 kdist    kernel      53616 Nov 30 17:04 
patch-2.5.1-pre4-pre5.gz

The naming and function of the patches should be obvious.

.bz2 and .sign files are available too, of course.

	-hpa

