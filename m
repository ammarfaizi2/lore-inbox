Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTLEDod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 22:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTLEDod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 22:44:33 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:57729
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263846AbTLEDob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 22:44:31 -0500
Date: Thu, 4 Dec 2003 22:42:32 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: John Stoffel <stoffel@lucent.com>
cc: grundig@teleline.es, Mathieu Chouquet-Stringer <mathieu@newview.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Kernel 2.6.0-test11 doesn't boot on a Dell 410
In-Reply-To: <16335.63931.101809.717476@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.58.0312042242040.2976@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0312041607180.27578@montezuma.fsmlabs.com>
 <16335.44623.99755.811085@gargle.gargle.HOWL> <16335.63931.101809.717476@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003, John Stoffel wrote:

>   LD      arch/i386/boot/setup
>   OBJCOPY arch/i386/boot/compressed/vmlinux.bin
>   GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
>   LD      arch/i386/boot/compressed/piggy.o
>   LD      arch/i386/boot/compressed/vmlinux
>   OBJCOPY arch/i386/boot/vmlinux.bin
>   BUILD   arch/i386/boot/bzImage
>
>
> I'm not sure if this is a valid error, or just a tool chain issue.
>
> Some too versions:
>
> gcc 3.3.2 (Debian)
> as  2.14.90.0.7 20031029 Debian GNU/Linux

Toolchain issue, but go ahead anyway.
