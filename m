Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267240AbUBSVdC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267573AbUBSVdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:33:02 -0500
Received: from a213-22-30-111.netcabo.pt ([213.22.30.111]:31971 "EHLO
	r3pek.homelinux.org") by vger.kernel.org with ESMTP id S267240AbUBSVcw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:32:52 -0500
Message-ID: <37833.62.229.71.110.1077226354.squirrel@webmail.r3pek.homelinux.org>
In-Reply-To: <20040219130808.0eab897e.rddunlap@osdl.org>
References: <12608.62.229.71.110.1077197623.squirrel@webmail.r3pek.homelinux.org>
    <20040219130808.0eab897e.rddunlap@osdl.org>
Date: Thu, 19 Feb 2004 21:32:34 -0000 (WET)
Subject: Re: Hot kernel change
From: "Carlos Silva" <r3pek@r3pek.homelinux.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 19 Feb 2004 13:33:43 -0000 (WET) "Carlos Silva"
> <r3pek@r3pek.homelinux.org> wrote:
>
> | hi,
> |
> | i would like to know if isn't it possible to implement a hot kernel
> | change, i mean, without reboot. i would do it myself if i had the
> knoledge
> | to do it but i'm starting with kernel-level programing now. i think it
> | would be possible if we make something like M$'s OS do when it
> hibernates,
> | copy all the memory, registers, etc to the disc and then put all back
> | again.
> |
> | am i dreaming or this is possible? :)
>
> The kexec patch is basically "linux reboots linux".
> It bypasses the firmware/BIOS to do the reboot.
>
> Patches for 2.6.0 and 2.6.1 are here (I haven't updated for
> 2.6.2 or 2.6.3 yet):
>   http://developer.osdl.org/rddunlap/kexec/
>
> Patches for some 2.5.x kernels are here:
>   http://www.xmission.com/~ebiederm/files/kexec/
>
> kexec does reduce reboot time quite a bit on some machines, but
> there is still a noticeable pause.
>

well, what can i say? this is nice, really nice :) but still reboots the
machine... :D
but it's a thing that i will test when a patch for the 2.6.3 kernel gets out.
