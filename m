Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbUKXQfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbUKXQfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbUKXQd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:33:28 -0500
Received: from smtp-242.ig.com.br ([200.226.132.242]:7587 "EHLO
	email-242.ig.com.br") by vger.kernel.org with ESMTP id S262673AbUKXQci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:32:38 -0500
Message-ID: <41A4B7AF.5030506@ig.com.br>
Date: Wed, 24 Nov 2004 14:32:47 -0200
From: "Olavo B D'Antonio" <olavobdantonio@ig.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Audio problems on AMD64 with Via K8T800 chipset
References: <E1CWyoi-00070L-00@mastermind.netrics.internal>
In-Reply-To: <E1CWyoi-00070L-00@mastermind.netrics.internal>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-iGspam-global: Unsure, spamicity=0.688629 - pe=6.89e-01 - pf=0.688629 - pg=0.688629
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same problem...

My system is a AMD64 3200+, motherboard MSI K8T-Neo with on-board sound 
VIA VT8237.

I'm running kernel 2.6.9.

Olavo D'Antonio

Eric Sharkey wrote:
> I've posted about this problem earlier on the Alsa lists, but
> Takashi Iwai has suggested I post here, since he thinks this is
> a kernel issue.
> 
> 
> There seems to be a problem with Alsa when running on the AMD64
> architecture on motherboards with the Via K8T800 chipset.  The sound
> is highly irregular, with lots of drop-outs, but also speed-ups,
> slow-downs and weird volume changes.
> 
> I've got this problem on an Asus K8V SE motherboard.  Rod Smith
> has the same problem on an MSI Neo-FSR.
> (http://groups.google.com/groups?q=%22asus+k8v%22+alsa&hl=en&lr=&c2coff=1&selm=1et59c-90v.ln%40speaker.rodsbooks.com&rnum=4)
> 
> In that post, Rod thought the problem was the Alsa driver for the
> on-board sound (VIA VT8237), but this is not the case, as I've installed
> a PCI Trident 4DWave NX, and it shows exactly the same behavior.
> The problem appears not to be in the low level driver code.
> 
> The degree of the problem is highly sensitive to the load on the
> CPU at the time.  Games like bumprace, which use multiple threads
> and never sleep (giving load values around 8), sound awful.  Most
> games like tuxkart, which keep the load under 1, sound perfectly fine.
> 
> And yet, some things sound bad even when the CPU isn't loaded.
> timidity++ is a good example.
> 
> This happens with both 64 and 32 bit kernels, and no amount of
> twiddling with kernel parameters (ACPI/CPU frequency scaling, apic,
> preemption, etc.) seems to make any difference.
> 
> Can anyone here offer a suggestion?
> 
> (Currently, I'm running 2.6 series kernels.  I haven't yet tried
> older versions.)
> 
> Eric
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

