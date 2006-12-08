Return-Path: <linux-kernel-owner+w=401wt.eu-S1425569AbWLHPd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425569AbWLHPd7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425567AbWLHPd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:33:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3200 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1425569AbWLHPd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:33:57 -0500
Date: Fri, 8 Dec 2006 16:34:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Bauke Jan Douma <bjdouma@xs4all.nl>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Daniel Ritz <daniel.ritz@gmx.ch>, Daniel Drake <dsd@gentoo.org>,
       Jean Delvare <khali@linux-fr.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Tomasz Koprowski <tomek@koprowski.org>
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-ID: <20061208153405.GA3356@stusta.de>
References: <20061207132430.GF8963@stusta.de> <20061207165352.9cb61023.vsu@altlinux.ru> <45784F0C.7040005@xs4all.nl> <20061207183217.GA7865@procyon.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207183217.GA7865@procyon.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 09:32:17PM +0300, Sergey Vlasov wrote:
> On Thu, Dec 07, 2006 at 06:27:40PM +0100, Bauke Jan Douma wrote:
>...
> > I for one need this quirk to get both soundcards at all (which
> > I need) -- no matter what indexing order.
> 
> I don't question the need for this patch in mainline; however, it does
> not seem to be suitable for -stable.
>...

Thanks to both of you.
First of all, I agree that this is not 2.6.16 material.

And looking at this issue at my A7V600-X, it's also a "feature" of this 
quirk that it enables the onboard audio even if you explicitely disabled 
it in the BIOS. I'm not sure about the correct solution in this case.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

