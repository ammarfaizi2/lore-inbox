Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137041AbREKDf7>; Thu, 10 May 2001 23:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137043AbREKDfu>; Thu, 10 May 2001 23:35:50 -0400
Received: from cj46222-a.reston1.va.home.com ([65.1.136.109]:17537 "HELO
	troilus.org") by vger.kernel.org with SMTP id <S137041AbREKDfn>;
	Thu, 10 May 2001 23:35:43 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100/usb interrupts stop with 2.4.x kernels?
In-Reply-To: <E14y9Mt-0002GH-00@the-village.bc.nu>
From: Michael Poole <poole@troilus.org>
Date: 10 May 2001 23:35:43 -0400
In-Reply-To: <E14y9Mt-0002GH-00@the-village.bc.nu>
Message-ID: <m34rush81c.fsf@troilus.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Solid Vapor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > What seems to happen is that the kernel stops seeing interrupts on the
> > IRQ shared by eth0 (my outside interface) and usb-uhci.  I can still
> > ssh in on eth1, and when I do, syslog contains things like "eth0:
> > Interrupt timed out" and usb-uhci griping about devices that failed to
> > accept new endpoints.
> 
> Do you see this if you run a -ac kernel or apply the APIC 440BX patch ?

I haven't tried either, but I'm about to reboot into 2.4.4-ac4 to see
if it helps.  If it still happens, I'll get more of the syslog output
and try to figure out what got wedged.

-- Michael
