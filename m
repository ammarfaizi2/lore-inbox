Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSLIS43>; Mon, 9 Dec 2002 13:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbSLIS43>; Mon, 9 Dec 2002 13:56:29 -0500
Received: from users.linvision.com ([62.58.92.114]:15290 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S265909AbSLIS42>; Mon, 9 Dec 2002 13:56:28 -0500
Date: Mon, 9 Dec 2002 20:03:19 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>, erik@hensema.xs4all.nl,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/pci deprecation?
Message-ID: <20021209200318.A31996@bitwizard.nl>
References: <997222131F7@vcnet.vc.cvut.cz> <slrnav3qp5.1c2.usenet@bender.home.hensema.net> <20021207131559.GA737@gallifrey> <20021207174658.GD10322@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021207174658.GD10322@conectiva.com.br>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2002 at 03:46:58PM -0200, Arnaldo Carvalho de Melo wrote:
> Em Sat, Dec 07, 2002 at 01:15:59PM +0000, Dr. David Alan Gilbert escreveu:
> > * Erik Hensema (usenet@hensema.xs4all.nl) wrote:
> > > 
> > > Every half-decent installer autodetects all PCI devices. AND had lspci
> > > installed in the install image.
> > 
> > Yes, but wait till you find yourself stuck on a weird embedded board
> > with a small flash and a serial console and you are trying to debug the
> > PCI device you've built.
> 
> In this weird embedded board with small flash it'd be lovely to save one
> more page (or perhaps more) in the kernel image, no? :-)

Agreed. But -=*if*=- I want to. 

I would personally prefer to spend the page in the (compressed in flash!)
kernel image than the nine pages or so for "lspci" (possibly compressed
as well). 
 
	Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
