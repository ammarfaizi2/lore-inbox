Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRK0OWL>; Tue, 27 Nov 2001 09:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279783AbRK0OWB>; Tue, 27 Nov 2001 09:22:01 -0500
Received: from hermes.domdv.de ([193.102.202.1]:13574 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S279778AbRK0OVu>;
	Tue, 27 Nov 2001 09:21:50 -0500
Message-ID: <XFMail.20011127152007.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E168ipq-00019Y-00@the-village.bc.nu>
Date: Tue, 27 Nov 2001 15:20:07 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: "spurious 8259A interrupt: IRQ7"
Cc: linux-kernel@vger.kernel.org, <martin@jtrix.com (Martin A. Brooks)>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I remember this was talked about earlier. Different mobos, chipsets,
processor brands, but always IRQ 7. /me wonders. At least it doesn't do any
harm (got this message on nearly all or all of my systems).

On 27-Nov-2001 Alan Cox wrote:
>> I get this with 2.4.16 vanilla, though. IRQ 7 appears to be unassigned
>> according to /proc/pci.
>> 
>> Machine is a 1ghz Athlon on a VIA VT82C686 mobo and a DEC 21140 NIC.
>> 
>> Any pointers appreciated.
> 
> IRQ7 is asserted when the PIC sees an interrupt but nobody appears to be
> generating it when it looks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
