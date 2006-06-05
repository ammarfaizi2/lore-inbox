Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751296AbWFES5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWFES5o (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWFES5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:57:44 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:25097 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751296AbWFES5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:57:43 -0400
Date: Mon, 5 Jun 2006 14:56:19 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <gregkh@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
        mb@bu3sch.de, st3@riseup.net
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
Message-ID: <20060605185614.GG6068@tuxdriver.com>
Mail-Followup-To: Jiri Slaby <jirislaby@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <gregkh@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
	mb@bu3sch.de, st3@riseup.net
References: <20060526001053.D2349C7C58@atrey.karlin.mff.cuni.cz> <44764D4B.6050105@pobox.com> <4476D63E.8090207@gmail.com> <4476D6EC.4060501@pobox.com> <4476D95B.5030601@gmail.com> <4476DA5C.9080602@pobox.com> <4476DE47.7010907@gmail.com> <4476E203.1080701@pobox.com> <4476E69F.6020502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4476E69F.6020502@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 01:29:12PM +0159, Jiri Slaby wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jeff Garzik napsal(a):
> > Jiri Slaby wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> Jeff Garzik napsal(a):
> >>> The point is that you don't need to loop over the table,
> >>> pci_match_one_device() does that for you.
> >> The problem is, that there is no such function, I think.
> >> If you take a look at pci_dev_present:
> > 
> > The function you want is pci_dev_present().
> Nope, it returns only 0/1.

Did we get a resolution on this?  I don't think Jeff is going to pull
this patch from me until you satisfy him that it is correct... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
