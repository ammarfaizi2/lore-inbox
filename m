Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262628AbREVQwy>; Tue, 22 May 2001 12:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262643AbREVQwo>; Tue, 22 May 2001 12:52:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:9745 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262628AbREVQwj>; Tue, 22 May 2001 12:52:39 -0400
Message-ID: <3B0A9937.369A2FF0@transmeta.com>
Date: Tue, 22 May 2001 09:52:07 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <3B0A28C0.2FFFC935@TeraPort.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin.Knoblauch" wrote:
> 
> >>
> >> Hi,
> >>
> >> while trying to enhance a small hardware inventory script, I found that
> >> cpuinfo is missing the details of L1, L2 and L3 size, although they may
> >> be available at boot time. One could of cource grep them from "dmesg"
> >> output, but that may scroll away on long lived systems.
> >>
> >
> >Any particular reason this needs to be done in the kernel, as opposed
> >to having your script read /dev/cpu/*/cpuid?
> >
> >        -hpa
> 
>  terse answer: probably the same reason as for most stuff in
> /proc/cpuinfo :-)
> 

Terse but just plain wrong.

Most stuff in /proc/cpuinfo is either hard (under some set of
circumstances) for userspace to obtain, or it is used by the kernel
itself anyway.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
