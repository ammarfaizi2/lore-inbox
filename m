Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130399AbRALMBu>; Fri, 12 Jan 2001 07:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131187AbRALMBk>; Fri, 12 Jan 2001 07:01:40 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:9488 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S130399AbRALMBX>;
	Fri, 12 Jan 2001 07:01:23 -0500
Date: Fri, 12 Jan 2001 14:01:15 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: Danny ter Haar <dth@lin-gen.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PRoblem with pcnet32 under 2.4.0 , was :Drivers under 2.4
In-Reply-To: <20010112125010.A6371@lin-gen.com>
Message-ID: <Pine.LNX.4.30.0101121357370.707-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Danny ter Haar wrote:
> According to Hans Grobler:
> > If you're willing, would you please follow "REPORTING-BUGS" and send some
> > more info. Also cat /proc/interrupts. This one's intriging...

Thanks for the report (still studying it).

> lspci -vx output:
>
> 00:0f.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (

What about the other devices?

> irq  0:     16840 timer                 irq  9:         0 acpi, PCnet/FAST III

Ok, this may not mean much, but have you tried compiling without acpi?
Just to remove some variables...

-- Hans

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
