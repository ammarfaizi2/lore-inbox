Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSFZQzW>; Wed, 26 Jun 2002 12:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSFZQzV>; Wed, 26 Jun 2002 12:55:21 -0400
Received: from quimbies.gnus.org ([80.91.231.2]:20096 "EHLO quimbies.gnus.org")
	by vger.kernel.org with ESMTP id <S316681AbSFZQzU>;
	Wed, 26 Jun 2002 12:55:20 -0400
Mail-Copies-To: never
X-Now-Playing: Various's _The State Of E:motion Vol. 9 (1)_: "The Dining
 Rooms - Pure & Easy"
To: linux-kernel@vger.kernel.org
Subject: Re: ALI15X3 (was: Problems with Maxtor 4G160J8 and 2.4.19-* +/-
 ac*)
References: <m3ofe2vpa4.fsf@quimbies.gnus.org> <m3hejurrez.fsf@quimbies.gnus.org>
 <20020624151824.GA5902@branoic.them.org>
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Date: Wed, 26 Jun 2002 18:55:02 +0200
In-Reply-To: <20020624151824.GA5902@branoic.them.org> (Daniel Jacobowitz's
 message of "Mon, 24 Jun 2002 11:18:24 -0400")
Message-ID: <m3it46geu1.fsf@quimbies.gnus.org>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2.50
 (i686-pc-linux-gnu)
X-Face: |J<QVf=k`T-jXM)(_(Kd|tqyDY1F9w~?HqTZRE,BiLSV.!iapu2!y8nzv|(}$38JkG.?nkl
 TE9i$9P*ulVWX+].9ixf)@S
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz <dan@debian.org> writes:

> I've had a lot of problems with ALI15x3; the patch that let me boot
> (found somewhere on the net, do not remember the original author)
> commented out the pci_read_config_byte and two pci_write_config_byte
> calls right below the comment that says "set south-bridge's enable
> bit".  Recent -ac kernels have this in two places.  DMA still works
> after doing that; does this work for you?

I tried commenting out various pci_writes/pci_reads, but I'm not
familiar enough with the code to say whether what I did was
meaningful or not.

In any case, it still didn't let me boot the machine with the 160GB
disk installed.

I've now bought a Highpoint Rocket133SB card and plugged the 160GB
disk into that instead, and everything works fine.  I get DMA to my
main disk via the ALI15X3 controller, and DMA to the 160GB disk via
the Rocket card.

-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen
