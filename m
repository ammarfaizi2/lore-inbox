Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTLTM4D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 07:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTLTM4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 07:56:03 -0500
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:23518 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S264252AbTLTM4A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 07:56:00 -0500
From: Paul Misner <paul@misner.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 don't boot (2.6.0-test9-bk16 does) (Attempted to kill init!)
Date: Sat, 20 Dec 2003 06:55:58 -0600
User-Agent: KMail/1.5.94
References: <20031220111928.GA15124@magma.epfl.ch>
In-Reply-To: <20031220111928.GA15124@magma.epfl.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312200655.59105.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 December 2003 05:19 am, Gregoire Favre wrote:
> Hello,
>
> I am using a Mandrake Cooker with 2.6.0-test9-bk16 and it works really
> great, I haven't tested post 2.6.0-test9-bk16 kernels.
> Compiling and booting the 2.6.0 with same config I got:
>
> Linux version 2.6.0 (greg@greg.greg) (gcc version 3.3.2 (Mandrake Linux
> 10.0 3.3.2-3mdk)) #21 Sat Dec 20 00:34:22 CET 2003 BIOS-provided physical
> RAM map:
(snip)
> Freeing unused kernel memory: 168k freed
> hub 4-0:1.0: new USB device on port 1, assigned address 2
> INIT: version 2.85 booINIT: Kernel panic: Attempted to kill init!
> INIT: cannot ex ecute "/etc/rc.d/rc.sysinit"
> <6>SysRq : Resetting
>
> Any idea what I should do?
>
> I only read this ml through nntp so if you need some other info please
> CC to me ;-)
>
> Thank you very much,
>
> 	Grégoire
> ________________________________________________________________________
> http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

This should be fixed with a gcc update.  Mandrake released a version that had 
a problem that seemed to show up only on kernel compiles.  Make sure you are 
updated to their gcc-3.3.2-3mdk package, which came out Thursday.  It fixed 
this problem for my system.  The gcc-3.3.2-2mdk version is the bad one.

Paul
