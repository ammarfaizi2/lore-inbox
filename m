Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280722AbRKGAe0>; Tue, 6 Nov 2001 19:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280723AbRKGAeU>; Tue, 6 Nov 2001 19:34:20 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:3499 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280709AbRKGAdo>;
	Tue, 6 Nov 2001 19:33:44 -0500
Date: Wed, 07 Nov 2001 00:33:40 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alexander Viro <viro@math.psu.edu>, Ricky Beam <jfbeam@bluetopia.net>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <812030885.1005093219@[195.224.237.69]>
In-Reply-To: <Pine.GSO.4.21.0111061709340.29465-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0111061709340.29465-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, 06 November, 2001 5:14 PM -0500 Alexander Viro 
<viro@math.psu.edu> wrote:

> On Tue, 6 Nov 2001, Ricky Beam wrote:
>
> [snip]
>> And those who *will* complain that binary structures are hard to work 
with,
>> (you're idiots too :-)) a struct is far easier to deal with than text
>> processing, esp. for anyone who knows what they are doing.  Yes, changes
>
> Learn C, then learn some respect to your betters[1], then come back.
>
> *PLONK*
>
> [1] like, say it, guys who had invented UNIX and C.

What amuses me about those arguing for binary structures as a long term
solution for communicating, on a flexible but long lived basis, is that the
entire OS Genre they appear to be advocating (UNIX et al.) has been doing
this, on an app to app (as opposed to kernel to app) basis, for far longer
than most of them can remember, in situations where performance is far more
relevant, and pitted against far more 3l33t 5tud3nt2 than we we shake a
stick at, but /still/ they persist.

Through minor local idiocy, I had trashed my local lilo partition, and had
to try and boot with a Debian CD-Rom with a 2.2 kernel. I forgot to ask for
single user more. Not only did it boot first time, it booted fully, apart
from two minor things: no iptables, and (shock horror) the sound card
didn't work it wasn't compatible. Similarly, I've loaded 2.4 kernels with
no problems onto 2.2 systems.

This "dreadful" /proc interface everyone talks about has been *STAGGERINGLY
GOOD* in terms of forward and backward compatibility. Sure, the innards may
smell unpleasant, but I reckon the interface, in practice, whilst not in
BNF format (BTW what is, and and, for the compsci philosophers amongst you,
'.*' as a regexp is easilly convertible into BNF and describes the /proc
interface completely - lexical and synatical analysis is immaterial without
tight semantic definition), has worked well just because kernel developers
and maintainers have showed themselves unwilling to break existing
userspace tools, and vice versa.

I think/thought we learnt our lesson on this in the fallout of the
Net2E/Net2D 'debate'. If someone is willing to stand up and say that /proc
external interface causes as many problems as the networking code did at
the time, please stand up and be counted now, preferably holding your
thesis on how to fix this for inter-app comms in Un*x in general, & forming
an orderly queue for the exit door :-)

--
Alex Bligh
