Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317849AbSHHSjz>; Thu, 8 Aug 2002 14:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317861AbSHHSjz>; Thu, 8 Aug 2002 14:39:55 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.21]:56915 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S317849AbSHHSjy>; Thu, 8 Aug 2002 14:39:54 -0400
Message-ID: <3D52BBD2.2050204@xs4all.nl>
Date: Thu, 08 Aug 2002 20:43:30 +0200
From: Rik van Ballegooijen <sleightofmind@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: parse error in ext2_fs_sb.h
References: <Pine.LNX.4.33.0208081441170.26994-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
>>When i was compiling some stuff, i got this error:
> 
> user-space or kernel-space stuff?
> 
>>Parse error before "u32"
>>
>>in the file (2.5.30):
>>
>>include/linux/ext2_fs_sb.h
> 
> 
> user-space should not use kernel headers.
> 
> 
>>I changed the u32 to __u32 and it worked. Is this a (proper) solution?

I was compiling quota-tools v3.06. The file quotacheck.c includes the 
named file on line 31.

Rik


