Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSHVSTb>; Thu, 22 Aug 2002 14:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSHVSTa>; Thu, 22 Aug 2002 14:19:30 -0400
Received: from ns1.ionium.org ([62.27.22.2]:44814 "HELO mail.ionium.org")
	by vger.kernel.org with SMTP id <S315457AbSHVST2> convert rfc822-to-8bit;
	Thu, 22 Aug 2002 14:19:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
Date: Thu, 22 Aug 2002 20:28:10 +0200
User-Agent: KMail/1.4.2
References: <3D6245DC.3A189656@hrzpub.tu-darmstadt.de> <3D64AB95.DC8FD965@hrzpub.tu-darmstadt.de> <1030038521.3161.17.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1030038521.3161.17.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208222028.10303.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 August 2002 19:48, you wrote:
> On Thu, 2002-08-22 at 10:15, Jens Wiesecke wrote:
> > So again my question: Can I do anything to help to debug this problem ?
>
> The version it broke at it is itself a lot of help. Build a kernel with
> no apm, no acpi, no agp, no compiled in audio, non smp, non numa, no
> apic support.
>
> Let me know if that boots

i guess it won't help..
if Jens Problem really is the very same as mine (which looks like it.. same 
pre6 works, pre7 fails) then the problem seems to be located in 
arch/i386/kernel/setup.c

if i use a pre7 kernel, with the arch/i386/kernel/setup.c from pre6... then 
the kernel will boot !

--
Best Regards
Justin Heesemann
