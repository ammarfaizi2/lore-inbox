Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272851AbRIGU5x>; Fri, 7 Sep 2001 16:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272853AbRIGU5n>; Fri, 7 Sep 2001 16:57:43 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:58382 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272851AbRIGU5g>;
	Fri, 7 Sep 2001 16:57:36 -0400
Date: Fri, 7 Sep 2001 13:57:03 -0700
From: Greg KH <greg@kroah.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: USB IRQ routing problems on Via Apollo Pro 133A
Message-ID: <20010907135703.D25421@kroah.com>
In-Reply-To: <20010906004520.A2891@hexapodia.org> <20010906202536.A11264@middle.of.nowhere> <20010907154129.B9370@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010907154129.B9370@hexapodia.org>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 03:41:29PM -0500, Andy Isaacson wrote:
> 
> Booting a non-APIC kernel makes it work, of course.
> 
> The system is a Tyan Tiger 133A, Via Apollo Pro 133A chipset, SMP,
> currently running 2.4.9.  Complete dmesg, lspci -vvvvxxxx, and
> /proc/interrupts are at
> http://web.hexapodia.org/~adi/straum/usb/

That's the only solution to enable the on board USB controller for this
motherboard, sorry.  If you can't live with noapic mode, spend $20 for
a PCI USB controller.

thanks,

greg k-h
