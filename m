Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVADRA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVADRA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVADRA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:00:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48332 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261725AbVADRAk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:00:40 -0500
Date: Tue, 4 Jan 2005 12:31:27 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Till Kamppeter <till.kamppeter@gmx.net>
Cc: Rene Rebe <rene@exactcode.de>, George Garvey <tmwg-sane@inxservices.com>,
       sane-devel <sane-devel@lists.alioth.debian.org>,
       linux-kernel@vger.kernel.org, oliver@neukum.org, torvalds@osdl.org
Subject: Re: Please remove hpusbscsi Was: [sane-devel] HP 7450C, hpusbscsi, permissions in Fedora Core 3
Message-ID: <20050104143127.GA7399@logos.cnet>
References: <1104646290.5821.99.camel@localhost.localdomain> <20050102101258.GB8385@inxservices.com> <41D999CD.80105@exactcode.de> <41DAD6DA.70205@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DAD6DA.70205@gmx.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I would rather prefer leaving it in the tree marked as broken than
completly removing the source, for 2.4 at least?

On Tue, Jan 04, 2005 at 06:48:10PM +0100, Till Kamppeter wrote:
> I have reported this to our Mandrakesoft kernel guys, so next 
> Mandrakelinux version (10.2) should not have this problem any more.
> 
> http://qa.mandrakesoft.com/show_bug.cgi?id=12891
> 
> For now, simply remove or rename the module on your system.


>    Till
> 
> 
> Rene Rebe wrote:
> >Hi,
> >
> >we should remove hpusbscsi from the Kernel. It is long obsolete and very 
> >unstable. I can send a patch for 2.4 and 2.6 (if needed) ;-)
> >
> >George Garvey wrote:
> >
> >>On Sat, Jan 01, 2005 at 10:11:30PM -0800, Thomas Frayne wrote:
> >
> >
> >...
> >
> >>   As far as I know, Rene has made it pretty clear he doesn't want to
> >>use hpusbscsi with the avision driver. He prefers libusb.
> >
> >
> >Yes. Hpusbscsi has many drawbacks. The major ones are:
> >
> > - does not work with new scanners (that are designed for USB 2.0)
> > - it is highly instable (e.g. during an i/o error it locks up
> >   quite easily and leaves the (usb sub-)system in a state that
> >   needs a reboot ...
> >
> >The later problem made me add the user-space i/o code to the 
> >SANE/Avision backend, because I had to reboot my system every 5 minutes 
> >during development ...
> >
> >Yours,
> >
