Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSLGSp7>; Sat, 7 Dec 2002 13:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSLGSp6>; Sat, 7 Dec 2002 13:45:58 -0500
Received: from r2w29.mistral.cz ([62.245.86.29]:4992 "EHLO ppc.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S264666AbSLGSp5>;
	Sat, 7 Dec 2002 13:45:57 -0500
Date: Sat, 7 Dec 2002 19:52:52 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>, jgarzik@pobox.com
Subject: Re: /proc/pci deprecation?
Message-ID: <20021207185252.GC1588@ppc.vc.cvut.cz>
References: <997222131F7@vcnet.vc.cvut.cz> <20021207131424.GL32065@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021207131424.GL32065@louise.pinerecords.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2002 at 02:14:24PM +0100, Tomas Szepe wrote:
> > > IMO, yes, since those tools provide the summary, and exist almost purely in
> > > userspace. I forgot to mention in the orginal email that we could also drop
> > > the PCI names database, right? This would save a considerable amount in the
> > > kernel image alone..
> > 
> > If you want, make it user configurable like it was during 2.2.x. But
> > I personally prefer descriptive names and system overview I can parse 
> > without having mounted /usr to get working lspci.
> 
> Actually I'm inclined to insist that lspci belong in /sbin.  Really.  :)

Try it. At least on Debian it is useless without name database, which lives in
/usr/share/misc/pci.ids...  I can read numbers directly from /proc/bus/pci, if
I want numbers.
							Petr Vandrovec
							vandrove@vc.cvut.cz
