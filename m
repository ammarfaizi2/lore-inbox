Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVBCNua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVBCNua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 08:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVBCNua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 08:50:30 -0500
Received: from alog0241.analogic.com ([208.224.222.17]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262534AbVBCNt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 08:49:57 -0500
Date: Thu, 3 Feb 2005 08:47:44 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Greg KH <greg@kroah.com>
cc: Pavel Roskin <proski@gnu.org>, Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Please open sysfs symbols to proprietary modules
In-Reply-To: <20050203003010.GA15481@kroah.com>
Message-ID: <Pine.LNX.4.61.0502030842170.8997@chaos.analogic.com>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
 <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net> <20050202232909.GA14607@kroah.com>
 <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain>
 <20050203003010.GA15481@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Greg KH wrote:
> On Wed, Feb 02, 2005 at 07:07:21PM -0500, Pavel Roskin wrote:
>> On Wed, 2 Feb 2005, Greg KH wrote:
>>> On Wed, Feb 02, 2005 at 03:23:30PM -0800, Patrick Mochel wrote:
>>>>
>>>> What is wrong with creating a (GPL'd) abstraction layer that exports
>>>> symbols to the proprietary modules?
>>>
>>> Ick, no!
>>>
>>> Please consult with a lawyer before trying this.  I know a lot of them
>>> consider doing this just as forbidden as marking your module
>>> MODULE_LICENSE("GPL"); when it really isn't.
>>
>> There will be a GPL'd layer, and it's likely that sysfs interaction will
>> be on the GPL'd side anyway, for purely technical reasons.  But it does
>> feel like circumvention of the limitations set in the kernel.
>
> It is.  And as such, it is not allowed.
>
>> I thought it would be polite to ask the developers to lift those
>> limitations, considering that they seem unfair and inconsistent with
>> the stated purpose of EXPORT_SYMBOL_GPL.
>
> No, the stated purpose of that marking is to prevent non-GPLd code from
> using those symbols.  I don't see how you can state that using sysfs
> files in your driver does not make it a "derived work" and force you to
> make all of your driver GPL.
>

If the purpose is as you say, then it is illegal in the
United States and probably elsewhere. It represents
theft of intellectual property.

I know something about modules. I created the
first module-like interface so that I didn't
have to reboot my system hundreds of times
while I was working on one of the first SCSI
drivers (the AH-1542 driver). Of course it was
not as sophisticated as the existing system and
it was designed to replace only one driver. It
also couldn't replace it forever because it
would run out of RAM (the existing driver was
not removed). Nevertheless, this was the
idea that started what Bas Laarhoven and Eric
Youngdale developed. In principle, a software
patent could probably have been obtained and
I could have prevented Linux modules for 17
years. Instead, early motivation when Linus
was still in college, was to help build an
operating system that would destroy Microsoft.

Everything we did was done for the sole purpose
of replacing the predatory garbage that Microsoft
was flooding into the market. Nothing I did
was done under the auspices of Mr. Stallmen's
so-called GNU Public License. In fact, I
helped port lots of BSD utilities to Linux.
The Linux API was designed to be exactly the
same as BSD so it usually involved only a
recompilation and fixing some syntax that was
no longer considered correct by the newer
compiler.

While many of the Linux community were watching
to see if Microsoft would steal its way into
Linux, enter employees of IBM Corporation
(read the current `insmod` man page for details).

>From time-to-time certain persons take what
thousands have written in the past and attempt
to regulate the use of those works. This was
first done by the use of the "GPL" symbol which
was required to exist within a module or else
the entire kernel was marked "tainted" and
considered to have been destroyed by a
defective module, should anybody report
a bug. This was touted as a "protection".
Note how somebody set out to protect you
from some problem you didn't know you had!

Then, the entire module system was moved from
user-mode code to inside the kernel. This was
a quite obvious attempt to obfuscate the use
of modules and create a logical wall where
modules that did not propagate the GPL symbol
conversion would not be allowed to work at all.

However there are work-arounds. So the next-step
has been to change all the exported symbols to
symbols that can only be found in a artificial
section created to further obfuscate interfacing
with the kernel. This is the GPL only symbol
theft that has now been planted within the
kernel.

I use the word theft in its true meaning.
Further, the usurping of power from the Linux
community as a whole to the individual(s) that
have perpetrated this conversion could certainly
be shown in a US court to be essentially the
theft of intellectual property. This theft
has occurred in little pieces, each so small
that they tend to be ignored. The locking up
of the Linux internals so that only those
who ascribe to a particular political view
may use these internals, could never be
allowed, should these actions be brought
before a United States Court.

So, my advice to you is to do what you need to do.
If anybody sues you or your company, you stand
on solid moral ground, but on untouched legal
ground since nobody has yet tested GPL and what
it means within the courts.

There are many work-arounds for the continuing 
theft of the Linux communities intellectual
property. Linking with a "GPL" do-nothing
object-file comes to mind.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
