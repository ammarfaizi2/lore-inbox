Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSLBV0H>; Mon, 2 Dec 2002 16:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbSLBV0H>; Mon, 2 Dec 2002 16:26:07 -0500
Received: from ulima.unil.ch ([130.223.144.143]:3555 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S265250AbSLBV0G>;
	Mon, 2 Dec 2002 16:26:06 -0500
Date: Mon, 2 Dec 2002 22:33:35 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: What does that mean (2.5.50)?
Message-ID: <20021202213335.GB28863@ulima.unil.ch>
References: <20021202212421.GA28863@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021202212421.GA28863@ulima.unil.ch>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 10:24:21PM +0100, Gregoire Favre wrote:

> matroxfb: framebuffer at 0xDC000000, mapped to 0xe0805000, size 33554432
> Uninitialised timer!
> This is just a warning.  Your computer is OK
> function=0xc02a654c, data=0x0
> Call Trace:
>  [<c0123e7f>] check_timer_failed+0x63/0x65
>  [<c02a654c>] cursor_timer_handler+0x0/0x3c
>  [<c0123ec0>] add_timer+0x3f/0xa1
>  [<c02a68fa>] fbcon_startup+0x4b/0x4d
>  [<c023c400>] take_over_console+0x29/0x1c8
>  [<c02a5be8>] register_framebuffer+0xe9/0x16d
>  [<c02ad111>] initMatrox2+0x849/0xaba
>  [<c02ad810>] matroxfb_probe+0x286/0x2da
>  [<c021e80a>] pci_device_probe+0x5e/0x6c
>  [<c0227746>] bus_match+0x45/0x7d
>  [<c0227847>] driver_attach+0x51/0x69
>  [<c0227b13>] bus_add_driver+0xa7/0xcd
>  [<c0227ef5>] driver_register+0x2f/0x33
>  [<c01703c5>] create_proc_entry+0x88/0xbc
>  [<c021e922>] pci_register_driver+0x47/0x57
>  [<c010506e>] init+0x3d/0x15a
>  [<c0105031>] init+0x0/0x15a
>  [<c0107079>] kernel_thread_helper+0x5/0xb
> 
> Console: switching to colour frame buffer device 200x75

Is the principal question...

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
