Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVCUIWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVCUIWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 03:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVCUIWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 03:22:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34064 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261674AbVCUIWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 03:22:33 -0500
Date: Mon, 21 Mar 2005 08:22:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Jacques Goldberg <Jacques.Goldberg@cern.ch>
Subject: Re: Need break driver<-->pci-device automatic association
Message-ID: <20050321082228.A22099@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Jacques Goldberg <Jacques.Goldberg@cern.ch>
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain> <20050318165124.GC14952@kroah.com> <Pine.LNX.4.58_heb2.09.0503192021431.11358@localhost.localdomain> <20050321081638.GC2703@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050321081638.GC2703@pazke>; from pazke@donpac.ru on Mon, Mar 21, 2005 at 11:16:38AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 11:16:38AM +0300, Andrey Panin wrote:
> On 078, 03 19, 2005 at 08:33:14PM +0200, Jacques Goldberg wrote:
> >    That's really what is needed (mainline).
> >    I attach the file which Sasha, author or the lmodem driver, has
> > modified and then it works for the chips hard-wired in the routine.
> >    To locate the patched area, look for 5457
> 
> We can use PCI quirk here. Patch attached.

I haven't seen any mail in this thread which provides the complete
PCI ID information for these cards.  Can someone oblige please, with:

lspci -vv

for the relevant card.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
