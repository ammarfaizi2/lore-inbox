Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131142AbRBJAuR>; Fri, 9 Feb 2001 19:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbRBJAt5>; Fri, 9 Feb 2001 19:49:57 -0500
Received: from [216.161.55.93] ([216.161.55.93]:10992 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131140AbRBJAtn>;
	Fri, 9 Feb 2001 19:49:43 -0500
Date: Fri, 9 Feb 2001 16:53:09 -0800
From: Greg KH <greg@wirex.com>
To: John Cavan <johnc@damncats.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mucho timeouts on USB
Message-ID: <20010209165309.S10691@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, John Cavan <johnc@damncats.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3A8489DE.D8C2B80A@damncats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8489DE.D8C2B80A@damncats.org>; from johnc@damncats.org on Fri, Feb 09, 2001 at 07:22:54PM -0500
X-Operating-System: Linux 2.2.16-22_6.x_imnx_17 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2001 at 07:22:54PM -0500, John Cavan wrote:
> 
> Current config:
> 
> Dual P3-500 w/ 512mb of RAM
> Tyan Tiger 133 mobo with VIA chipset, onboard USB
> Kernel 2.4.1-ac9 compiled with egcs-1.1.2

This motherboard does not currently work with USB in SMP mode, unless
you boot with "noapic" on the command line.  People are working on it,
but it's slow going.

FWIW, Windows2000 refuses to also work for this VIA USB chipset :)

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
