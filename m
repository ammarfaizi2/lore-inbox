Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281055AbRKKUwd>; Sun, 11 Nov 2001 15:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281065AbRKKUwX>; Sun, 11 Nov 2001 15:52:23 -0500
Received: from cx662584-c.okcnc1.ok.home.com ([65.13.170.37]:53406 "EHLO
	cx662584-c.okcnc1.ok.home.com") by vger.kernel.org with ESMTP
	id <S281055AbRKKUwJ>; Sun, 11 Nov 2001 15:52:09 -0500
Message-ID: <3BEEE61A.6050002@uhura.rueb.com>
Date: Sun, 11 Nov 2001 14:56:58 -0600
From: Steve Bergman <steve@uhura.rueb.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: steve@rueb.com
Subject: Best kernel config for exactly 1GB ram
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have just upgraded my athlon 1200 system to 1GB ram.  I am unclear as 
to how I should configure the kernel for this box.  The config.help says 
   to say no to "high memory support" if the kernel will not run on a 
machne with more than 1GB.  When I do this I notice that my available 
memory as reported by top is ~ 120MB less than if I say I want 4GB 
support.  I recall that linux reserves some of the address space for 
itself (I thought it was just 64MB).

What are the trade offs involved here?  Am I better off sacrificing a 
bit of the physical memory for reasons of efficiency elsewhere?  When I 
request support for up to 4GB, what exactly changes with respect to the 
visible virtual address space that apps see, etc?

This is a desktop machine, so it's not running Oracle or anything like 
that.  I seem to recall Linus mentioning that big databases tend to like 
the large (3GB) virtual address space.

Any enlightenment would be greatly appreciated.



Thanks,
Steve Bergman
steve@rueb.com

