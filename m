Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbTKVRzb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbTKVRzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:55:31 -0500
Received: from intra.cyclades.com ([64.186.161.6]:53203 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262581AbTKVRz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:55:29 -0500
Date: Sat, 22 Nov 2003 15:31:49 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: modular IDE in 2.4.23
In-Reply-To: <200311221746.03690.arekm@pld-linux.org>
Message-ID: <Pine.LNX.4.44.0311221530480.1290-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 22 Nov 2003, Arkadiusz Miskiewicz wrote:

> Hi,
> 
> Modular IDE no longer works in 2.4.23 (I'm testing rc3). I'm getting
> 
> depmod: *** Unresolved symbols 
> in /lib/modules/2.4.23-0.1/kernel/drivers/ide/ide-core.o
> depmod:         init_cmd640_vlb
> depmod:         ide_wait_hwif_ready
> depmod:         ide_probe_for_drive
> depmod:         ide_probe_reset
> depmod:         ide_tune_drives
> 
> This is regression since in 2.4.21 and 2.4.22 modular IDE was working fine on 
> my x86.
> 
> Is anyone working on fixing that regression?

>From what I remember its not simple to fix.

Alan?


