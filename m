Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280474AbRKGK4s>; Wed, 7 Nov 2001 05:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280510AbRKGK4h>; Wed, 7 Nov 2001 05:56:37 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:42906 "HELO hazard.jcu.cz")
	by vger.kernel.org with SMTP id <S280474AbRKGK43>;
	Wed, 7 Nov 2001 05:56:29 -0500
Date: Wed, 7 Nov 2001 11:55:09 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cannot unlock spinlock... Was: Problem in yenta.c, 2nd edition
Message-ID: <20011107115509.F11351@hazard.jcu.cz>
In-Reply-To: <20011107111056.E11351@hazard.jcu.cz> <E161Pyh-0003hb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E161Pyh-0003hb-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

On Wed, Nov 07, 2001 at 10:30:39AM +0000, Alan Cox wrote:
> 
> Can you disable the winmodem in the BIOS at all. I've seen similar reports
> of audio hangs where the IRQ was shared by a lucent winmodem - no idea
> why since it ought to be passive and minding its own business.

I'm sorry, but this is the Compaq Armada notebook and in its BIOS
I can't disable even ACPI or this device :-((( Maybe it is
possible in special "BIOS setup program" which can be load from
Compaq rescue partition: however I remove this partition :-(

I can only remove this device physically from notebook...

But I have good news (maybe): when I switch off ACPI in the
kernel config, I can work with PCMCIA w/o David's patch...
(New kernel fetched from sgi CVS, because I have xfs on the root
filesystem, version is 2.4.14-xfs) ;-))))

Thank you for advice...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
