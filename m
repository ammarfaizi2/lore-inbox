Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSHIUCn>; Fri, 9 Aug 2002 16:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSHIUCn>; Fri, 9 Aug 2002 16:02:43 -0400
Received: from freeside.toyota.com ([63.87.74.7]:52748 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S315690AbSHIUCm>; Fri, 9 Aug 2002 16:02:42 -0400
Message-ID: <3D5420BC.7090002@lexus.com>
Date: Fri, 09 Aug 2002 13:06:20 -0700
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020802
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitch Sako <msako@cadence.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -aa 3.5GB Patch Questions
References: <3D541969.48A1D9E3@cadence.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a sanity check, are you using the
current (errata) red hat gcc?

Just asking since 2.96 is all I use, and
the -aa kernels are completely stable
here - do you have a test workload to
allow me to try and duplicate your bug?

Joe

Mitch Sako wrote:

>I've been using Andrea's 2.4.18rc4aa1 patches applied to a generic
>2.4.18 kernel running on Intel 32-bit machines with 4GB of memory and
>usually some sort of Serversorks chipset with 1-2 CPUs of various speeds
>with great success for almost 6 months now.  The primary base has been a
>SuSE 7.2 distro but others are now being tried, including Slackware 8.1
>and RH 7.[23].  The principal reason for this was to use the
>00_3.5G-address-space-4 feature.  I apply all patches in the directory
>and have not seen a kernel failure yet with thousands of hours of "big
>process" CPU time logged across many machines.  I consider this to be a
>pretty stable combination of kernel and patches for what I need.
>
>RH's 2.96 gcc compiles fine but blows up or slows to a crawl (not
>unexpected) when big jobs are run and the machine starts paging.  I've
>fixed this by putting a 2.95.3 gcc on the machine.  I'll leave the
>editorial comments about 2.96-RH to others.
>
>I'm trying to write some sanitized procedures which will allow me to
>pass this on to others.  Non-2.96 distros (everyone except RH and
>Mandrake, AFAIK) have run fine without issues, mainly because they have
>a pretty stable 2.95 compiler included.
>
>I will assume that a gcc 2.95 retrofit is required to make the -aa
>patches work on RH 7.[23].
>
>What's the correct way to retrofit a 2.95.3 compiler onto an RH 7.[23]
>distro?
>Is it OK to just load it into /usr/local and build it?
>Does it require 'make bootstrap' to be entirely santized?
>Are there other GNU packages that I should be including with the gcc
>retrofit?
>
>-ms
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

