Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUKTHf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUKTHf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUKTHf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:35:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:60051 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262897AbUKTHev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:34:51 -0500
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some
	machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Hentges <mailinglisten@hentges.net>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1100921760.3561.1.camel@mhcln03>
References: <1100811950.3470.23.camel@mhcln03>
	 <20041119115507.GB1030@elf.ucw.cz> <1100872578.3692.7.camel@mhcln03>
	 <1100872578.3692.7.camel@mhcln03> <1100905563.3812.59.camel@gaston>
	 <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
	 <1100921760.3561.1.camel@mhcln03>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 18:34:19 +1100
Message-Id: <1100936059.5238.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 04:36 +0100, Matthias Hentges wrote:
> Am Samstag, den 20.11.2004, 02:43 +0000 schrieb Matthew Garrett:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > >> Sorry, that's beyond my abilities. That's why I'm posting here. I'm not
> > >> even sure that it's the radeon which is acting up here.
> > > 
> > > Have you tried with radeonfb in your kernel config ?
> > 
> > In the general case, it's harder to resume systems using framebuffers
> > than systems that don't. The contortions that are necessary for non-fb
> > systems tend to break fb systems (you end up with userspace and the
> > kernel both trying to get the graphics hardware back into a sane state),
> > so in an ideal world resume would work without any framebuffer support.
> 
> Trying to resume with radeonfb or X (DRI or fglrx) causes the machine
> to freeze upon a resume.

At what point does it freeze ? Is the display back before the freeze ?

Ben.


