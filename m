Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318224AbSHIKkD>; Fri, 9 Aug 2002 06:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318234AbSHIKkD>; Fri, 9 Aug 2002 06:40:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19448 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318224AbSHIKkC>; Fri, 9 Aug 2002 06:40:02 -0400
Date: Fri, 9 Aug 2002 12:43:41 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: bege <bege@inf.elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: bug-report
In-Reply-To: <Pine.A41.4.31.0207301658480.48216-100000@pandora.inf.elte.hu>
Message-ID: <Pine.NEB.4.44.0208091239250.26570-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, bege wrote:

>...
> 2.
> --
> I got an OOPS kernel message (described below) while i was compiling
> XFree86 with gcc-3.0 and g++-2.95

Is this more or less reproducible or did it happen exactly once?

> 3.
> --
> I used the -mcpu=athlon -march=athlon parameters in the makefile although
> g++-2.95 doesn't support this. But i think it may be cause compile errors
> not kernel crash.

Yes, this is right, it mustn't result in a kernel crash.

> 4.
> --
>
> Linux version 2.4.18 (root@void) (gcc version 3.0.4) #11 Tue Jul 30 13:33:15 CEST 2002
>...

Could you try 2.4.19?

gcc-3.0.4 is not a supported compiler. Please try to reproduce the problem
with a kernel compiled using gcc 2.95.3 or a RedHat gcc-2.96-74 or later.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

