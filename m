Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWCNQYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWCNQYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWCNQYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:24:24 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:13966 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751197AbWCNQYY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:24:24 -0500
Date: Tue, 14 Mar 2006 10:23:50 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: Allen Pradeep <allenpradeep@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reg. sis 900 drivers
Message-ID: <20060314162350.GA4060@us.ibm.com>
References: <a07a17720603140629o86b9974xb85eb9728dde5a55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07a17720603140629o86b9974xb85eb9728dde5a55@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your lspci shows that you have a sis190 adapter (not a sis900).  See if
using that driver fixes your problem.

Thanks,
Jon

On Tue, Mar 14, 2006 at 07:59:23PM +0530, Allen Pradeep wrote:
> sir, i'm a linux novice user.. i run fedora core3 and winXP.. i'm
> using a asus mother board which comes with a internal sis900 ethernet
> card. whenever i start fedora i get an error message stating
> "Sis 900 device eth0 does not seem to be present. Delaying initialization"
> 
> i'm also not able to connect to the internet. with winXP i can!!!!
>  i wrote a mail to webmaster@brownhat.org with outputs of the
> following commands:
> >modprobe sis900
> >dmesg
> >lspci
> 
> he gave a reply stating that sis900 adapter is not found in your
> system: his reply was this
> "I don't think that you have a sis900 adapter in your computer. lspci
> lists your network adapter as unknown, so I think you should write to
> linux-kernel@vger.kernel.org (the main development list) and ask for
>  help there"
> 
>  so i have mailed u regarding this... i'm really interested in linux
> and because i'm not able to connect to the net, i'm using winXP
>  i've run the following commands:
> > modprobe sis900 > foo.txt
> > dmesg > bar.txt
> > lspci > baz.txt
>  and have attached foo.txt, bar.txt, baz.txt along with this mail...
> 
>  i would be greateful to you if u help me in solving this problem.
> please send the drivers needed and also tell me how to install them
> since i'm a novice user...
>  thanking you in advance
>  hoping for a prompt response...
<snip>
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 760/M760 Host (rev 03)
> 00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202
> 00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS965 [MuTIOL Media IO] (rev 47)
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 01)
> 00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
> 00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
> 00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
> 00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
> 00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
> 00:04.0 Ethernet controller: Silicon Integrated Systems [SiS]: Unknown device 0190
> 00:06.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 000a
> 00:07.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 000a
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 661FX/M661FX/M661MX/741/M741/760/M760 PCI/AGP

