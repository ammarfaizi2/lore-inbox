Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265020AbUEUWtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265020AbUEUWtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUEUWq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:46:28 -0400
Received: from pop.gmx.net ([213.165.64.20]:21203 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264828AbUEUWpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:45:23 -0400
X-Authenticated: #199736
Date: Fri, 21 May 2004 01:04:14 +0200
From: Corin Langosch <corinl@gmx.de>
Reply-To: Corin Langosch <corinl@gmx.de>
X-Priority: 3 (Normal)
Message-ID: <859031054.20040521010414@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: dual opteron problems
In-Reply-To: <200405200521.i4K5Lvlv005934@bach.leonora.org>
References: Your message of "Wed, 19 May 2004 19:37:32 +0200."
 <689626123.20040519193732@gmx.de> <200405200521.i4K5Lvlv005934@bach.leonora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

--
sorry for posting again, but couldn't anyone help me?
would be more than nice!!
--

thanks you your reply. unluckily i cant find an option
for that in the bios. its the latest bios available.

one more debug output:
when the system hangs after "vfs: mounted root (cramfs filesystem)"
it sometimes outputs:
CPU 1: Machine Check Exception: 0000000000000000000004
Bank 4: b200000000000000000070f0f
Kernel panic: CPU context corrupt

can anyone help me with that? would be really nice!!
does anybody have a running dual opteron system here?
could anyone tell if my hardware has errors or if
this is software related..?

Thanks,
Corin

Thursday, May 20, 2004, 7:21:57 AM, you wrote:
VGI> I have an ancient dual processor Pentium III machine (ASUS CUV4X-DLS)
VGI> for which I had to disable MPS 1.4 in the BIOS to get it to work.
VGI> Apparently there's not much difference between MPS 1.1 and 1.4. Give it
VGI> a whirl. At worst it'll cost you two reboots.
 
VGI> --- Vladimir

VGI> ------------------------------------------------------------------------
VGI> Vladimir G. Ivanovic                        http://leonora.org/~vladimir
VGI> 2770 Cowper St.                                         vladimir@acm.org
VGI> Palo Alto, CA 94306-2447                                 +1 650 678 8014
VGI> ------------------------------------------------------------------------
>>>>>> "cl" == Corin Langosch <corinl@gmx.de> writes:

VGI>     cl> 
VGI>     cl> Hi all,
VGI>     cl> i just bought a new 2x244 opteron,tyan tiger k8s 2870,
VGI>     cl> 4gb registered ecc ram system. no addional cards
VGI>     cl> inserted, only one IDE and one SATA device.
VGI>     cl> 
VGI>     cl> i tried to run the setup with the original debian
VGI>     cl> kernel 2.6.6-1-k7-smp, but the system hangs right
VGI>     cl> after the line "initrd-tools: 0.1.69".
VGI>     cl> 
VGI>     cl> so i downloaded the sources for 2.6.6 and compiled
VGI>     cl> them myself, optimized for dual opteron. unluckily
VGI>     cl> exactly the same happens.
VGI>     cl> 
VGI>     cl> when i enable the apic 2.0 support in the bios, the
VGI>     cl> system hangs even ealier right after the first
VGI>     cl> "calibrating delay loop...".
VGI>     cl> 
VGI>     cl> when i boot the system with the "nosmp" and apic 2.0
VGI>     cl> disabled (normal apic still enabled) the system
VGI>     cl> hangs somewhere after "hda: max request size...".
VGI>     cl> 
VGI>     cl> the only way to get the system running is to fully
VGI>     cl> disable the apic support in the bios and run the
VGI>     cl> system with "nosmp". :-(((
VGI>     cl> 
VGI>     cl> i hope that anyone could help me,
VGI>     cl> corin
VGI>     cl> 
VGI>     cl> -
VGI>     cl> To unsubscribe from this list: send the line "unsubscribe linux-smp" in
VGI>     cl> the body of a message to majordomo@vger.kernel.org
VGI>     cl> More majordomo info at  http://vger.kernel.org/majordomo-info.html
VGI>     cl> 

