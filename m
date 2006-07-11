Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWGKPay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWGKPay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWGKPay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:30:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28435 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751290AbWGKPax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:30:53 -0400
Date: Tue, 11 Jul 2006 17:30:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Hering <olh@suse.de>
Cc: Theodore Tso <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       klibc@zytor.com, torvalds@osdl.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711153052.GW13938@stusta.de>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <20060711134554.GC24029@thunk.org> <20060711151347.GA15625@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711151347.GA15625@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 05:13:47PM +0200, Olaf Hering wrote:
>  On Tue, Jul 11, Theodore Tso wrote:
> 
> > > In earlier mails you stated that having kinit/klibc in the kernel sources
> > > would make it easier to keep up with interface changes.
> > > What interface changes did you have in mind, and can you name any relevant
> > > interface changes that were made after 2.6.0 which would break an external
> > > kinit?
> > 
> > When you load a SCSI driver (the one that bit me was the MPT Fusion
> > driver), it no longer waits for SCSI bus probe to finish before
> > returning.  So the RHEL4 initrd fails to find the root filesystem, and
> > bombs out.  This change was definitely made after 2.6.0, and is an
> > example of the sort of change which wouldn't have happened if kinit
> > was under the kernel sources and not supplied by the distro.
> 
> Was RHEL4 designed for 2.6?

Yes (it uses 2.6.9).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

