Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbUKETou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUKETou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKETm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:42:29 -0500
Received: from alog0368.analogic.com ([208.224.222.144]:19072 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261188AbUKETjU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:39:20 -0500
Date: Fri, 5 Nov 2004 14:38:29 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: David Schwartz <davids@webmaster.com>
cc: adam@yggdrasil.com, jp@enix.org,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Possible GPL infringement in Broadcom-based routers
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEBPPJAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.61.0411051418330.21421@chaos.analogic.com>
References: <MDEHLPKNGKAHNMBLJOLKGEBPPJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, David Schwartz wrote:

>
>> 	I think you're missing the idea that that such drivers are
>> _contributory_ infringement to the direct infringement that occurs when
>> the user loads the module.
>
> 	Except that loading the module is not infringement. The GPL does not
> restrict use of GPL'd code in any way.
>
>> In other words, even for a driver that has
>> not a byte of code derived from the kernel, if all its uses involve it
>> being loaded into a GPL'ed kernel to form an infringing derivative
>> work in RAM by the user committing direct copyright infringement against
>> numerous GPL'ed kernel components, then it fails the test of having
>> a substantial non-infringing use, as established in the Betamax decision,
>> and distributing it is contributory infringement of those GPL'ed
>> components of the kernel.
>
> 	In order for there to be an "infringing derivative work", some clause of
> the GPL would have to be infringed. There exists no clause in the GPL that
> restricts the *creation* of derivative works that are not distributed.
>
> 	If your argument were correct, then no non-GPL'd software could *ever* be
> distributed for Linux. You see, loading that software would create an
> "infringing derivative work" in the memory of the computer running it,
> combining the Linux kernel with the software.
>
> 	DS
>

As I understand it, anything that executes in the user-mode
environment provided by the kernel, using the kernel-provided
API(s), either through a runtime library or direct, using the
kernel interface(s), is not a derivative work of the kernel.

Anything that runs inside the kernel is a derivative work.
There used to be a "gray area" which has now been obliterated
with the new module-loading software. There is now no question
about the derivative works of a module because a module is now
data used by the kernel's built-in loading mechanism. It cannot
anymore be confused with a "program".

So, if the Broadcom router uses a linux kernel with its
built-in network routing capability, that's fair use.

If it has a user-interface program for configuring it,
that user-interface program can be considered proprietary
and its code can be private intellectual property.

If the kernel is unmodified, its source doesn't have to
be provided with the box. If there are special modules or
special modifications, then these have to be made available
if requested by any individual. The company can charge normal
distribution fees for this software source-code.

In the meantime, you can do anything you want with any
portion of linux as long as you do it in the privacy of
your own bedroom ;^;)


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
