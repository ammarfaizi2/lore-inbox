Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131983AbRBFABa>; Mon, 5 Feb 2001 19:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132156AbRBFABL>; Mon, 5 Feb 2001 19:01:11 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:63245 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S131983AbRBFABH>; Mon, 5 Feb 2001 19:01:07 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE644@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Juraj Bednar'" <juraj@bednar.sk>,
        acpi@phobos.fachschaften.tu-muenchen.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: [Acpi] acpi breaks async interface
Date: Mon, 5 Feb 2001 15:59:26 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, someone else had PPP slowness due to ACPI idle, so I'd guess that's
the problem here too.

Workin' on it -- Andy

> From: Juraj Bednar [mailto:juraj@bednar.sk]
>  I just found a strange thing in 2.4.1 (don't know, if the same
> occured in 2.4.0) and 2.4.1-ac3. When I enable ACPI, my serial
> port starts to drop some characters. When making ppp over this
> and doing ping, it causes great packet losts. If I turn ACPI in
> this configuration off, it works with no problems. I tried to
> switch serial port IRQ to other one (was 4, switched to 3 and
> tested) and it didn't help. Maybe something's broken.

Where is ACPI below???

> [root@idoru log]# cat /proc/interrupts 
>            CPU0       
>   0:      57278          XT-PIC  timer
>   1:       2658          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   4:      49530          XT-PIC  serial
>   5:          1          XT-PIC  soundblaster
>  10:         15          XT-PIC  aha152x
>  11:         60          XT-PIC  eth0
>  12:      27772          XT-PIC  PS/2 Mouse
>  14:     213118          XT-PIC  ide0
>  15:       3298          XT-PIC  ide1
> NMI:          0 
> LOC:          0 
> ERR:          0

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
