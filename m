Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287048AbSAYAm0>; Thu, 24 Jan 2002 19:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSAYAmR>; Thu, 24 Jan 2002 19:42:17 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:36579 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S287048AbSAYAmA>;
	Thu, 24 Jan 2002 19:42:00 -0500
Date: Thu, 24 Jan 2002 16:41:57 -0800
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: jt@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Trigraph warning cleanup for wavelan_cs in 2.5.3-pre5
Message-ID: <20020124164157.F12682@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020124162233.C12682@bougret.hpl.hp.com> <20020124193925.I4459@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020124193925.I4459@redhat.com>; from bcrl@redhat.com on Thu, Jan 24, 2002 at 07:39:25PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 07:39:25PM -0500, Benjamin LaHaise wrote:
> On Thu, Jan 24, 2002 at 04:22:33PM -0800, Jean Tourrilhes wrote:
> > 	Hi Linus,
> > 
> > 	This is a trivial patch that fixes some trigraph warning and
> > was a leftover of the driver backport. I think adding that to your
> > tree would please Jeff.
> 
> Doesn't -Wno-trigraphs in the top level makefile avoid this?  Or is the 
> file in question not being complied with the correct flags?
> 
> 		-ben

	I have no idea, I've nevern seen that on my boxes. Jeff Garzik
told me that I had to do this, so as it was only cosmetic, I just did
the patch. Please ask him for details...

	Jean
