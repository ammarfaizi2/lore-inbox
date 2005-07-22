Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVGVDkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVGVDkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVGVDkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:40:41 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:36323
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261943AbVGVDki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:40:38 -0400
Message-ID: <42E05CAB.9020703@linuxwireless.org>
Date: Thu, 21 Jul 2005 21:40:43 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
CC: Mark Nipper <nipsy@bitgnome.net>, linux-kernel@vger.kernel.org
Subject: Re: Giving developers clue how many testers verified certain kernel
 version
References: <42E04D11.20005@ribosome.natur.cuni.cz> <20050722021046.GB21727@king.bitgnome.net> <42E05C17.2000305@ribosome.natur.cuni.cz>
In-Reply-To: <42E05C17.2000305@ribosome.natur.cuni.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJŠ wrote:

> Hi,
>
> Mark Nipper wrote:
>
>>     I have a different idea along these lines but not using
>> bugzilla.  A nice system for tracking usage of certain components
>> might be made by having people register using a certain e-mail
>> address and then submitting their .config as they try out new
>> versions of kernels.
>
>
> Nice idea, but I still think it is of interrest on what hardware
> was it tested. Maybe also 'dmesg' output would help a bit, but
> I still don't know how you'd find that I have _this_ motherboard
> instead of another.
>
I'm a simple Linux user that normally likes to test as much things as 
posible. This is what I would do:

I would make a Summary of the ChangeLog that was done to the kernel, and 
from there encourage people to test those parts. The worst part that I 
face against Linux is that I don't know C enough like to understand what 
the patch that someone sent will really do.

    A user understandable ChangeLog so that people can test those 
changed points would be great. And if those changes could have an 
explanation on how users could troubleshoot the change, then it would be 
fairly awesome.

    I have been subscribed here for more than a year already, and I have 
barely understood a couple of changes that have been done to Drivers and 
to the kernel itself. How can I make sure that the change will really 
work better for me?

    How does one check if hotplug is working better than before? How do 
I test the fact that a performance issue seen in the driver is now fixed 
for me or most of users? How do I get back to a bugzilla and tell that 
there is a bug somewhere when one can't really know if that is the way 
it works but is simply ugly, or if there is really a bug?

    My point is that a user like me, can't really get back to this 
mailing list and say "hey, since 2.6.13-rc1, my PCI bus is having an 
additional 1ms of latency" We don't really have a process to follow and 
then be able to say "ahha, so this is different" and then report the 
problem, even if we can't fix it because of our C and kernel skills.

    How do we know that something is OK or wrong? just by the fact that 
it works or not, it doesn't mean like is OK.

There has to be a process for any user to be able to verify and study a 
problem. We don't have that yet.

.Alejandro
