Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbTBFXkb>; Thu, 6 Feb 2003 18:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267554AbTBFXkb>; Thu, 6 Feb 2003 18:40:31 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:13723 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267543AbTBFXk2>; Thu, 6 Feb 2003 18:40:28 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 6 Feb 2003 15:49:48 -0800
Message-Id: <200302062349.PAA21867@adam.yggdrasil.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Restore module support.
Cc: zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-02-06, Greg KH wrote:
>On Fri, Feb 07, 2003 at 12:09:27AM +0100, Roman Zippel wrote:
>> Hi,
>> 
>> On Tue, 4 Feb 2003, Rusty Russell wrote:
>> 
>> > I'm going to stop here, since I don't think you understand what I am
>> > proposing, nor how the current system works: this makes is extremely
>> > difficult to describe changes, and time consuming.
>> 
>> Rusty, if you continue to ignore criticism, I have only one answer left:
>> 
>> http://www.xs4all.nl/~zippel/restore-modules-2.5.59.diff
>
>But what are the modutils numbers? :)
>
>Come on, what Rusty did was the "right thing to do" and has made life
>easier for all of the arch maintainers (or so says the ones that I've
>talked to), and has made my life easier with regards to
>MODULE_DEVICE_TABLE() logic, which will enable the /sbin/hotplug
>scripts/binary to shrink a _lot_.

	I'd be interested in some elaboration on these two points.

	I'd like to understand what problems were solved for other
architectures by putting the module loader into the kernel, so I could
compare what would be involved to delivering the same benefit with a
user-level module loader.

	I think the MODULE_DEVICE_TABLE stuff is largely independent
of whether the module loading is done inside the kernel or from user
level, but if this is due to some misunderstanding on my part, please
set me straight.

	Although I write this in response to a message by Greg KH, I
would welcome answers from anyone.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
