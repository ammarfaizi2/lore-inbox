Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278470AbRJOWtO>; Mon, 15 Oct 2001 18:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278473AbRJOWtE>; Mon, 15 Oct 2001 18:49:04 -0400
Received: from jalon.able.es ([212.97.163.2]:2499 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S278470AbRJOWsu>;
	Mon, 15 Oct 2001 18:48:50 -0400
Date: Tue, 16 Oct 2001 00:49:15 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: magallon@posta.unizar.es,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Status of ServerWorks UDMA
Message-ID: <20011016004915.A28798@werewolf.able.es>
In-Reply-To: <20011016003812.A28638@werewolf.able.es> <E15tGWg-0003fP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E15tGWg-0003fP-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Oct 16, 2001 at 00:48:02 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011016 Alan Cox wrote:
>> I have just installed a system with kernel 2.4.20, and it stops booting
>> with a message like:
>>

He, he, I meant 2.4.10....

>> 	Controller is in an impossible state. Disable UDMA.
>
>That is triggered when we see a case that can cause disk corruption.
>
>> Board is a SuperMicro 370DLE (SW LE chipset). I have tried disabling 
>> ide channels on the bios, but kernel still sees them. I have tried to
>
>At some point I'll sort this properly if Andre doesnt do it first.
>
>> boot with ide0=nodma (is this options real, or I just have invented it ??)
>> No solution.
>
>ide=nodma
>

TNX!!

>Please send me details on the system. lspci -v output too.
>

As I said, it is a SUPER P3TDLE, with 2 UDMA/33 channels, and a cdrom
in hda and a zip in hdc (nothing in any slave).
I will send you details tomorrow from work.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.12-ac2-beo #1 SMP Mon Oct 15 00:23:19 CEST 2001 i686
