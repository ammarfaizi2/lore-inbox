Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbSJOLlz>; Tue, 15 Oct 2002 07:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262454AbSJOLlz>; Tue, 15 Oct 2002 07:41:55 -0400
Received: from tailtiu.davidcoulson.net ([194.159.156.4]:31627 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id <S262448AbSJOLlz>; Tue, 15 Oct 2002 07:41:55 -0400
Message-ID: <3DAC0063.9080701@davidcoulson.net>
Date: Tue, 15 Oct 2002 12:47:47 +0100
From: David Coulson <david@davidcoulson.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020915
X-Accept-Language: en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       UML devel <user-mode-linux-devel@lists.sourceforge.net>
Subject: swap_dup/swap_free errors with 2.4.20-pre10
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.20-pre10 on a Dual PIII system with 2Gb of RAM and three 
2Gb swap logical volumes.

It runs fine for a while, then I get lots of;

Oct 15 12:41:31 maeve kernel: swap_dup: Bad swap file entry 00000020
Oct 15 12:41:31 maeve kernel: swap_dup: Bad swap file entry 00000020
Oct 15 12:41:31 maeve kernel: swap_free: Bad swap file entry 00000020
Oct 15 12:41:31 maeve kernel: swap_free: Bad swap file entry 00000020
Oct 15 12:41:31 maeve kernel: swap_dup: Bad swap file entry 00000020
Oct 15 12:41:31 maeve kernel: swap_dup: Bad swap file entry 00000020
Oct 15 12:41:31 maeve kernel: swap_free: Bad swap file entry 00000020

The address is always 00000020. I've tried the machine without any swap 
space, and I get exactly the same error, so I'm assuming it's either bad 
RAM or a kernel issue. I ran memtest86 on it yesterday, and it didn't 
throw up any errors, but I'm going to swap the RAM out and see if that 
fixes it.

Thanks,
David

-- 
David Coulson                                  http://davidcoulson.net/
d@vidcoulson.com                       http://journal.davidcoulson.net/

