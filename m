Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUCVTgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUCVTgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:36:46 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:46085 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262335AbUCVTgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:36:39 -0500
Date: Mon, 22 Mar 2004 11:14:37 -0800
From: "David Schwartz" <davids@webmaster.com>
To: "Tigran Aivazian" <tigran@veritas.com>,
       "Timothy Miller" <miller@techsource.com>,
       "Justin Piszcz" <jpiszcz@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Microcode Question
Message-ID: <WorldClient-F200403221114.AA14370017@webmaster.com>
X-Mailer: WorldClient 6.8.5
In-Reply-To: <Pine.GSO.4.58.0403220736480.8694@south.veritas.com>
References: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet>  <405F0B8D.8040408@techsource.com> <Pine.GSO.4.58.0403220736480.8694@south.veritas.com>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 22 Mar 2004 11:14:37 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 127.0.0.1
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mon, 22 Mar 2004, Timothy Miller wrote:
> > I don't see anything wrong with what he said.  As I understand it,
> > Pentium 4 CPUs don't use microcode for much of anything.  If an
> > instruction which was done entirely in dedicated hardware was buggy,
> > and
> > it's replaced by microcode, then it will most certainly be slower.
> >
> > You seem to have missed where David used terms like "theoretically
> > possible" and "an operation".
 
> No, that is not what he said and that (what you say) is certainly
> wrong,
> namely this bit:
> 
>   If an instruction which was done entirely in dedicated hardware was
>   buggy, and it's replaced by microcode, then it will most certainly be
>   slower.
> 
> All instructions are done by means of microcode of some sort, i.e. the
> instructions are "compiled" as they are executed into a more primitive
> instruction set (called "microcode" or "u-code"). If a buggy
> instruction
> (or rather the sequence of microcode which corresponds to it) is
> replaced
> by a fixed version (i.e. by some other sequence of microcode) then
> there
> is no reason to say that the result will "most certainly be slower".
> For
> some bugs the fix runs faster than the broken code, for others it may
> be
> slower --- there is no way to tell apriori that it will always be
> slower.
> 
> Do you understand now?

You are using the word "instruction" to mean something different than 
what I am using it to mean. I am using "instruction" to mean "the 
smallest cohesive unit of operation". I do NOT mean "instruction" as 
in "an operation coded by the programmer".

I am talking about the case where an "operation" performed in buggy 
hardware is replaced by an "operation" performed in fixed microcode.

By the way, the recent Intel patent lawsuit had this exact same issue. 
The word "instruction" can refer to *any* cohesive unit that performs 
some logical function.

DS

