Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUJORl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUJORl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUJORl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:41:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268251AbUJORhO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:37:14 -0400
Date: Fri, 15 Oct 2004 13:35:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Josh Boyer <jdub@us.ibm.com>, gene.heskett@verizon.net,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <1097860121.13633.358.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.61.0410151319460.6877@chaos.analogic.com>
References: <27277.1097702318@redhat.com>  <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
  <1097843492.29988.6.camel@weaponx.rchland.ibm.com> 
 <200410151153.08527.gene.heskett@verizon.net>  <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
  <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
 <1097860121.13633.358.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, David Woodhouse wrote:

> On Fri, 2004-10-15 at 12:59 -0400, Richard B. Johnson wrote:
>> We let this start when there were problems with secret video
>> modules. Nobody wanted to debug a kernel that could be corrupted
>> by a module where nobody could read the source-code. So if there
>> isn't a MODULE_LICENSE("POLICY") then a 'tainted' mark goes
>> in any OOPS report. Well, they got away with that. It was
>> explained away as being "good" policy. Now they are making
>> more policy.
>
> Please quit being a fuckwit, Richard. You've escaped my killfile so far
> despite being in so many other peoples, because it's often amusing to
> find the deliberate mistake in your posts when they actually appear
> plausible.
>
> The above is not policy; it's a mechanism. It provides the information.
> Developers _use_ that information to implement their own policy, and
> refrain from helping those whose kernels are tainted.
>
> Signing kernel modules is just the same.

You just don't get it. This is policy.

Script started on Fri 15 Oct 2004 01:13:59 PM EDT
# insmod xxx.ko
xxx: module license 'BSD' taints kernel.
# exit
Script done on Fri 15 Oct 2004 01:14:26 PM EDT

How dare somebody decide that a BSD license that
makes source-code available, but doesn't give its
control to Stallman, somehow taints the kernel.

Wake up! This is policy and bad policy, too.
If it wasn't for UC Berkeley, there wouldn't even
be a Linux, it was deliberately designed to be
compatible so the Berkeley (read UNIX) utilities
would run. This was well before GNU did anything
but a 'C' compiler and eimacs.

BTW us.ibm.com has an interesting policy, the
name in the DNS expires in a few minutes and only
becomes available for a few minutes each day. That
means that anything sent to Josh Boyer <jdub@us.ibm.com>,
in the c.c. list, above, gets cached here until the
name resolves.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

