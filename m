Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTBOW5f>; Sat, 15 Feb 2003 17:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbTBOW5f>; Sat, 15 Feb 2003 17:57:35 -0500
Received: from c16639.thoms1.vic.optusnet.com.au ([210.49.244.5]:55426 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S265355AbTBOW5e>;
	Sat, 15 Feb 2003 17:57:34 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: tbench as a load - DDOS attack?
Date: Sun, 16 Feb 2003 10:07:25 +1100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>, zwane@holomorphy.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302161007.25149.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zwane M suggested using tbench as a load to test one of his recent patches and 
gave me the idea to try using tbench_load in contest. Here are the first set 
of results I got while running tbench 4 continuously (uniprocessor machine):

tbench_load:
Kernel         [runs]   Time    CPU%    
test2420            1   180     38.9    
test2561            1   970     7.7   

This is a massive difference. Sure tbench was giving better numbers on 2.5.61 
but it caused a massive slowdown. I wondered whether this translates into 
being more susceptible to ping floods or DDOS attacks? You should have seen 
tbench 16 - 3546 seconds!

comments?
Con
