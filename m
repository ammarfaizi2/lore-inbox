Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVGaNJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVGaNJM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVGaNJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 09:09:12 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:47240 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261405AbVGaNJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 09:09:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=dqdKKnx4Iorpk0TNnrFaL0YGxYul49NyvVmxSrfjuTfWiiH1pS66UPVZBkn07GjzVlokUDw14iJHOKQil+IdNFIPEL9dJnOmkT4JE6sYerViIc0FfTjvg4IKcMGec3SOCMvjCJHh1R21pmIP4/dMaaySjGK5A4/Qn8QxcVZLpBs=
Message-ID: <42ECEA30.5060204@gmail.com>
Date: Sun, 31 Jul 2005 15:11:44 +0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050726)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4-mm1
References: <20050731020552.72623ad4.akpm@osdl.org>
In-Reply-To: <20050731020552.72623ad4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

the ACPI bug or the problems with 2.6.13-rc3-mm[2,3] gone.
The system boots now noiseless, except on problem with USB.

If my Prolific USB-Serialadapter  plugged in on reboot
the ehci_hcd driver complains about a Hand-off bug in Bios.

-> snip

ehci_hcd 0000:00:1d.7: EHCI Host Controller

ehci_hcd 0000:00:1d.7: debug port 1

ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 01010001)

ehci_hcd 0000:00:1d.7: continuing after BIOS bug...

ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1

ehci_hcd 0000:00:1d.7: irq 161, io mem 0xd2dffc00

-> snip


I wonder about this because all other USB devices working without this 
message on boot.

USB Mouse,Keyboard and USB Storage and all mixed from USB 1.1 and 2.

When I rebooted without plugged Prolific Adapter and plug them in the 
same port
the kernel prints this message.

->snip

usb 4-1: new full speed USB device using uhci_hcd and address 2

pl2303 4-1:1.0: PL-2303 converter detected

usb 4-1: PL-2303 converter now attached to ttyUSB0

-> snip


Any Ideas what could be wrong here?

Greets

Best regards
          Michael
