Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSEHPq6>; Wed, 8 May 2002 11:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314486AbSEHPq5>; Wed, 8 May 2002 11:46:57 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:10793 "EHLO
	hotmale.boyland.org") by vger.kernel.org with ESMTP
	id <S314485AbSEHPq4>; Wed, 8 May 2002 11:46:56 -0400
Message-ID: <3CD9486D.9000804@blue-labs.org>
Date: Wed, 08 May 2002 11:46:53 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] PPPoE w/ 2.4.19-pre6 (followup)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me amend my prior post.  I noticed that I am now getting an OOPS 
every time pppd is restarted.

 >>EIP; c024fc1f <pppoe_connect+13f/270>   <=====
Trace; c0127ab8 <handle_mm_fault+98/e0>
Trace; c0311ac3 <sys_connect+53/70>
Trace; c0147ac0 <fcntl_setlk+a0/200>
Trace; c03123eb <sys_socketcall+7b/210>
Trace; c0143f77 <sys_fcntl64+47/90>
Trace; c0108bb3 <system_call+33/40>


-d


