Return-Path: <linux-kernel-owner+w=401wt.eu-S1751739AbXAVOA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbXAVOA0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 09:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbXAVOA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 09:00:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:59932 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbXAVOA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 09:00:26 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mDxsVyF1N2LFlgjOcZxWGkcnjbFKil4zl/QAAD6ba2WQGAwiezEJn6iuIQvUAPHK+qt1Ms+Di55XOd6kNlEMq1DQ4xBXHdB65WL+cbvc4Awqm0fJ7IC/CcGUp8AJ3OGMr5E57hALueenVCfc+t2JL0jnCE0EcRQW8zm32ijx3jw=
Message-ID: <a71293c20701220600v426f0efdyc23dd945852f71c0@mail.gmail.com>
Date: Mon, 22 Jan 2007 09:00:23 -0500
From: "Stephen Evanchik" <evanchsa@gmail.com>
To: "Stefan Priebe - FH" <studium@profihost.com>
Subject: Re: SATA ahci Bug in 2.6.19.x
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45B46FA0.2060901@profihost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45B46FA0.2060901@profihost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/07, Stefan Priebe - FH <studium@profihost.com> wrote:

> I've an Asus A8V Mainboard which works wonderful with a 2.6.18.X kernel.
> But i cannot use the SATA Controller with a 2.6.19.x Kernel.

I also have an Asus A8V motherboard that cannot boot a newer kernel
because the SATA controller does not come up properly. I have tried
kernels 2.6.19.2 and 2.6.20-rc5 with no luck. It looks like later
kernels don't recognize the proper IRQ of the device as compared to
the 2.6.18 boot logs.

> "ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 21 (level, low) -> IRQ 21"
> "ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl IDE
> mode"
> "ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum part "
> "ata1: SATA max UDMA/133 cmd 0xFFFFC20000004D00 ctl 0x0 bmdma 0x0 irq 1277"
> "ata2: SATA max UDMA/133 cmd 0xFFFFC20000004D80 ctl 0x0 bmdma 0x0 irq 1277"
> "ata3: SATA max UDMA/133 cmd 0xFFFFC20000004E00 ctl 0x0 bmdma 0x0 irq 1277"
> "ata4: SATA max UDMA/133 cmd 0xFFFFC20000004E80 ctl 0x0 bmdma 0x0 irq 1277"

Similar output as above.


Does any one have any ideas?


Stephen
