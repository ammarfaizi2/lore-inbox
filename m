Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270923AbTGPPq2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270924AbTGPPq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:46:28 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4305 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270923AbTGPPq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:46:28 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200307161601.h6GG1IR25744@devserv.devel.redhat.com>
Subject: Re: new raid server crashed - no idea why!
To: raz@macs.hw.ac.uk (Ross Macintyre)
Date: Wed, 16 Jul 2003 12:01:18 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com,
       salvini@macs.hw.ac.uk, donald@macs.hw.ac.uk
In-Reply-To: <SIMEON.10307161613.A@pcraz.macs.hw.ac.uk> from "Ross Macintyre" at Gor 16, 2003 04:29:13 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> RedHat 8.0 software and the latest raid drivers from LSILogic.
> The spec of the machine is dual processor - AMD MP 2400+ with
> LSILogic MegaRAID 320-2, and adaptec ultra wide scsi.

The data roughly speaking says "it broke". Its not useful log data
alas.

>   BIOS failed to enable PCI standards compliance, fixing this error.
>   mtrr: your CPUs had inconsistent fixed MTRR settings
>   mtrr: probably your BIOS does not setup all CPUs)

Linux fixed both of these up. The former may indicate old BIOS rather
than anything much to worry about


If its a dual athlon run memtest86 on it for a few hours - thats my first
guess fro the traces and the fact the dual athlons are infamously 
sensitive about ram
