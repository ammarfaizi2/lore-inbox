Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSJ1AMs>; Sun, 27 Oct 2002 19:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262784AbSJ1AMp>; Sun, 27 Oct 2002 19:12:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40967 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262783AbSJ1AMm>;
	Sun, 27 Oct 2002 19:12:42 -0500
Message-ID: <3DBC825C.9060905@pobox.com>
Date: Sun, 27 Oct 2002 19:18:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Switching from IOCTLs to a RAMFS
References: <15804.28536.3553.712306@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

>>>>>>"Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:
>>>>>>            
>>>>>>
>
>
>Jeff> Like I touched on in IRC, there is room for both sysfs and per-driver 
>Jeff> filesystems.
>
>Jeff> I think just about everyone agrees that ioctls are a bad idea and a huge 
>Jeff> maintenance annoyance.  
>
>I note that the P1003.26 ballot has just been announced...
>
>  Title: P1003.26:  Information Technology -- Portable Operating  
>  System Interface (POSIX) -- Part 26:  Device Control  
>  Application Program Interface (API) [C Language] 
> 
>  Scope: This work will define an application program interface to  
>  device drivers.  The interface will be modeled on the  
>  traditional ioctl() function, but will have enhancements  
>  designed to address issues such as "type safety" and  
>  reentrancy. 
> 
>
>It may be worth looking at what the draft standard says before
>committing to yet another interface specification.
>  
>


Already looked at it.  It's awful, and retains many of the problems that 
ioctl(2) presents to kernel maintainers.

I sent a comment in to the only email address I could find describing 
the issues (politely!), but as a mere peon I doubt it will have much 
effect.  The best we can do is ignore this POSIX junk and hope it goes 
away...

    Jeff




