Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289098AbSAJA03>; Wed, 9 Jan 2002 19:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289099AbSAJA0T>; Wed, 9 Jan 2002 19:26:19 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:14239
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289098AbSAJA0N>; Wed, 9 Jan 2002 19:26:13 -0500
Date: Wed, 9 Jan 2002 17:25:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>, Greg KH <greg@kroah.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020110002507.GU13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk> <20020109214022.GE21963@kroah.com> <5.1.0.14.2.20020109215335.02cfc780@pop.cus.cam.ac.uk> <20020109231528.B25786@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109231528.B25786@devcon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 11:15:28PM +0100, Andreas Ferber wrote:
> On Wed, Jan 09, 2002 at 09:55:34PM +0000, Anton Altaparmakov wrote:
> > 
> > I would think that is a good idea but I am not sure that is what is planned 
> > / will happen. Keeping it outside would have the advantage that a newer 
> > partition recognizer (or whatever other code) can be applied to any 
> > existing kernel version (that supports initramfs).
> 
> This could be done anyway: just replace the initramfs image built by 
> the kernel build with anotherone built from another source tree. It
> would be helpful though if the tools were distributed both standalone
> and included into the kernel tree.

If the kernel is going to build an initramfs option, it also needs a way
to be given one.  The issue I'm thinking of is I know of a few platforms
where the initramfs archive will have to be part of the 'zImage' file
(much like they do for ramdisks now).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
