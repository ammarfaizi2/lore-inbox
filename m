Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287832AbSAFLyw>; Sun, 6 Jan 2002 06:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287833AbSAFLym>; Sun, 6 Jan 2002 06:54:42 -0500
Received: from t2.redhat.com ([199.183.24.243]:58613 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S287832AbSAFLyY>; Sun, 6 Jan 2002 06:54:24 -0500
Date: Sun, 6 Jan 2002 05:54:20 -0600 (CST)
From: Tommy Reynolds <reynolds@redhat.com>
X-X-Sender: <reynolds@dhcp-177.hsv.redhat.com>
To: Stepan Hluchan <stepan@3amp.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 - hang after 'freeing unused kernel memory'
In-Reply-To: <004a01c196a5$91964840$73552d3e@kabelfoon.nl>
Message-ID: <Pine.LNX.4.33.0201060550560.14583-100000@dhcp-177.hsv.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Stepan Hluchan wrote:

> I have installed the RedHat 7.2 distro (I think it comes with
> 2.4.10-something
> but that hangs too) on one machine A. and then transferred the HD to
> another (machine B) where it should be used.   On machine A (Celeron 800Mhz)
> it all boots up fine with any kernel, on machine B (P75 @ 100Mhz, ancient
> BIOS
> and mobo) it hangs after the message 'freeing up XX k unused kernel memory'.
> 
> I have compiled the 2.4.17, 2.4.0 kernels set to 'classic pentium', but both
> would
> hang...
> 
> What can be the cause for this?  (keep in mind it works fine on the newer
> machine)

Kernels hangs after the "freeing unused kernel memory" are the classic
symptom that the kernel has been compiled using the wrong CPU type.
Just for grins, try again using the next lower version of the CPU:
like a 586.  X86 CPU settings are mostly forward compatible, not
backwards compatible.

-- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- + -- -- -- -- -- -- -- -- -- --
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

