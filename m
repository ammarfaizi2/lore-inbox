Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271832AbRICWD4>; Mon, 3 Sep 2001 18:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271839AbRICWDq>; Mon, 3 Sep 2001 18:03:46 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:2827 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S271832AbRICWDg>; Mon, 3 Sep 2001 18:03:36 -0400
Message-ID: <3B93FE48.B53B5DF4@delusion.de>
Date: Tue, 04 Sep 2001 00:03:52 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Parallel Port doesn't detect EPP
In-Reply-To: <3B93DE17.92CF408E@delusion.de> <20010903220955.I20060@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:

> > #1) EPP is no longer listed as supported transfer mode, but it used
> >     to be.
> 
> <rule_out_the_obvious>
> Have you changed your BIOS setting since you last tried it?  What does
> your BIOS say about your parallel port?
> </rule_out_the_obvious>

My BIOS setting has always been "ECP+EPP". After Steffen's mail regarding
"ECP+EPP" I've changed my parport BIOS setting to "EPP" and using 2.4 I
now get:

parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]

I also tried 2.2. with "ECP+EPP" and it detects both ECP and EPP:
[SPP,ECP,ECPEPP,ECPPS2]

Apparently 2.4. doesn't detect the parport settings the same way 2.2. does.

Regards,
Udo.
