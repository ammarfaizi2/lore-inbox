Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267683AbTBFWoe>; Thu, 6 Feb 2003 17:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbTBFWoe>; Thu, 6 Feb 2003 17:44:34 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:40109 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267683AbTBFWoc>; Thu, 6 Feb 2003 17:44:32 -0500
Message-ID: <3E42E7B7.2080900@blue-labs.org>
Date: Thu, 06 Feb 2003 17:54:47 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030131
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: 2.5.59 OOPS w/ fdisk & devfs
References: <3E42D05E.8080907@blue-labs.org> <20030206135138.3c083007.akpm@digeo.com>
In-Reply-To: <20030206135138.3c083007.akpm@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, don't jump too fast :)

I have been having extreme hardware issues with this box for the past 
several hours.  I thought it was 2.5.59 giving me grief but an old 
kernel I had laying around presented similar issues.  I'm busy swapping 
cables, memory, etc to see who is being the bad guy.

So far, I've had issues with reiserfs, raw dd, mkreiserfs, tar, cp, mv 
(insert a lot of shell commands), interpreters, you name it.  Nothing 
seems common except that it all occurs when hda data is going somewhere 
else.  I just swapped my udma66 cable on hda and I'm trying to stress 
test hda now.

David

Andrew Morton wrote:

>David Ford <david+cert@blue-labs.org> wrote:
>  
>
>>Unable to handle kernel paging request at virtual address 6b6b6b87
>>...
>>EIP is at _devfs_unhook+0x2b/0x70
>>    
>>
>
>
>Look.  devfs is sick.  Richard has disappeared.  Al did some work on it and
>also disappeared.  Adam laid it on the ground and drove a truck over it, and
>I had that patch in -mm for two or three weeks and had one single, sole, sad,
>sorry report from a tester.
>  
>

