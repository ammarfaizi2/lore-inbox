Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270349AbRHIRk1>; Thu, 9 Aug 2001 13:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270456AbRHIRkH>; Thu, 9 Aug 2001 13:40:07 -0400
Received: from james.kalifornia.com ([208.179.59.2]:27493 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S270349AbRHIRkA>; Thu, 9 Aug 2001 13:40:00 -0400
Message-ID: <3B72CAF5.8010101@blue-labs.org>
Date: Thu, 09 Aug 2001 13:40:05 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ext2 problems in 2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the problem appears to have been fixed.  I venture the bug is likely 
in the e2fs tools for the simple reason that on the last time I took the 
machine down for maintenance, I ran e2fsck five times and got different 
results for the first three runs.  Now before everyone flys off the 
handle with their favorite flamethrower, the server was in single user 
mode with nothing else running but the kernel threads.  There weren't 
any processes left and lsof was also clean.  I have also been forcing 
fsck on boot every time.

The machine has been up for four days now without any errors and no 
unaccounted for disk space.

David


