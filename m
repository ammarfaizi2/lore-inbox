Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130535AbQKYAs2>; Fri, 24 Nov 2000 19:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130540AbQKYAsS>; Fri, 24 Nov 2000 19:48:18 -0500
Received: from slc807.modem.xmission.com ([166.70.6.45]:32268 "EHLO
        flinx.biederman.org") by vger.kernel.org with ESMTP
        id <S130535AbQKYAsG>; Fri, 24 Nov 2000 19:48:06 -0500
To: Ronald G Minnich <rminnich@lanl.gov>
Cc: I+D <jbertran@cirsa.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Booting AMD Elan520 without BIOS
In-Reply-To: <Pine.LNX.4.21.0011240917570.17415-100000@mini.acl.lanl.gov>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Nov 2000 15:31:56 -0700
In-Reply-To: Ronald G Minnich's message of "Fri, 24 Nov 2000 09:19:58 -0700 (MST)"
Message-ID: <m1y9y9vw6b.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald G Minnich <rminnich@lanl.gov> writes:

> On Fri, 24 Nov 2000, I+D wrote:
> 
> > I'm trying to boot an AMD Elan520 board without bios
> > with kernel 2.4.0-test10 configured for i486 and PCI direct access.
> > This kernel boots correctly from HD using the bios provided with the 
> > evaluation board but kernel 2.4.0-test8 and previous hang
> > after "Ok booting the kernel".
> 
> well, first I want your code for linuxbios :-)
> 
> > 	The last message I see is "Calibrating delay loop"
> > (I see this thaks to the Jtag debugger for Elan520 because
> > I haven't configured the VGA board yet).
> 
> you don't have clock interrupts on. If you are able to single step you'll
> probably see it in the loop spinning on jiffies. This is one of our
> regular problems with a new mainboard.

This can also easily be a misconfiguration of the local apic.
I might need to be put into virtual wire mode.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
