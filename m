Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311866AbSDNJ3X>; Sun, 14 Apr 2002 05:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSDNJ3W>; Sun, 14 Apr 2002 05:29:22 -0400
Received: from dns.uni-trier.de ([136.199.8.101]:37574 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S311866AbSDNJ3V>; Sun, 14 Apr 2002 05:29:21 -0400
Date: Sun, 14 Apr 2002 11:29:16 +0200 (CEST)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: brian@worldcontrol.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Is 2.4.19-pre5-ac3 destroying my laptop?
In-Reply-To: <20020414054141.GA1867@top.worldcontrol.com>
Message-ID: <Pine.LNX.4.40.0204141122400.4965-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2002 brian@worldcontrol.com wrote:

> Some of us with Sony FXA laptops have noticed our computers becoming
> rather hot.
>
> I'm running linux 2.4.19-pre5-ac3 and I've tried both ACPI w/acpid and
> APM w/lvcool, and there are occasions where the laptop becomes so hot
> that I turn it off.
>
> If I power back on, the BIOS immediately turns the fan on.
>
> When running with ACPI I'm using acpid-20010510.tar.gz.
>
> Any pointers that would help diagnose this problem before I or
> others fry CPUs would be appreciated.

acpi does not save any power on a computer whith an athlon or duron ,
when the "disconnect when spgnt detected" bit in the northbridge is not set.
this bit is not set by the acpi system of the kernel nor is it set by the
apm system. as far as i know acpid has nothing to do with this. the lvcool
patch only supports power saving on a few chipsets (kt133/133a, kx133) ...

do you know, which chipset is used by sony for this notebooks ?
maybee this could help ...

does lvcool say something, that the special idle loop is activated ?

daniel

# Daniel Nofftz .......................... #
# Sysadmin CIP-Pool Informatik ........... #
# University of Trier(Germany), Room V 103 #

The resonable man adapts himself to the world. The unreasonable
man persists in trying to adapt the world to himself. It follows
that all progress depends on the unresaonable man.
                                        George Bernard Shaw

