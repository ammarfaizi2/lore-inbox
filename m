Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267009AbRHWOX0>; Thu, 23 Aug 2001 10:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRHWOXR>; Thu, 23 Aug 2001 10:23:17 -0400
Received: from sub.sonic.net ([208.201.224.8]:2395 "EHLO sub.sonic.net")
	by vger.kernel.org with ESMTP id <S267009AbRHWOXB>;
	Thu, 23 Aug 2001 10:23:01 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 23 Aug 2001 07:23:15 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there any interest in Dynamic API
Message-ID: <20010823072315.A9288@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5C54F2B3.04BACD3A-ON80256AB1.004CA1FB@portsmouth.uk.ibm.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 02:58:44PM +0100, Richard J Moore wrote:
> 
> 
> On Thu, 23 Aug 2001, Alexander Viro <viro@math.psu.edu>:
> 
> > s/ioctl/read() and write()/, please.
> 
> Why not ioctl?


You can script things with read/write.  You have to write one off utilities
for ioctl.

Think having to require specialized tools like stty, hdparm, setserial, and
so on.  (Historical question:  Since IP sockets were originally /dev/* based,
was ifconfig essentially a wrapper around ioctls?)

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
