Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264846AbRGNTtQ>; Sat, 14 Jul 2001 15:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbRGNTtH>; Sat, 14 Jul 2001 15:49:07 -0400
Received: from p062.as-l031.contactel.cz ([212.65.234.254]:26884 "EHLO
	p062.as-l031.contactel.cz") by vger.kernel.org with ESMTP
	id <S264846AbRGNTs4>; Sat, 14 Jul 2001 15:48:56 -0400
Date: Sat, 14 Jul 2001 21:35:57 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using ACPI to get PCI routing info?
Message-ID: <20010714213557.E993@ppc.vc.cvut.cz>
In-Reply-To: <3B4F8A16.83EF0CA1@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B4F8A16.83EF0CA1@osdlab.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 04:53:58PM -0700, Randy.Dunlap wrote:
> Petr-
> 
> Where does someone find/get BIOS version F5a for the 6VXD7?
> The latest that I see on the Gigabyte web pages is F5.

It might be that F5a is older than F5, as on my filesystem
F5a has date Feb8, while F5 has Mar23 ... But it does not
matter, as both report same broken table, at least for me.
So I have kernel patched with self written IRQ routing table
instead of with BIOS's one, and machine is happy using
IRQ16-19. This implies that I did not coded retrieving
IRQ routing info from ACPI. With current discussions about
moving ACPI to userspace it might be even impossible, as
you for sure want console before you enter userspace,
but you cannot have console if you did not enumerate
devices (video card) yet...
				Best regards,
					Petr Vandrovec
					vandrove@vc.cvut.cz
