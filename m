Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUKTDjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUKTDjz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbUKTDgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 22:36:32 -0500
Received: from hentges.net ([81.169.178.128]:47548 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S263070AbUKTDgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 22:36:07 -0500
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some
	machines
From: Matthias Hentges <mailinglisten@hentges.net>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
References: <1100811950.3470.23.camel@mhcln03>
	 <20041119115507.GB1030@elf.ucw.cz> <1100872578.3692.7.camel@mhcln03>
	 <1100872578.3692.7.camel@mhcln03> <1100905563.3812.59.camel@gaston>
	 <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 04:36:00 +0100
Message-Id: <1100921760.3561.1.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, den 20.11.2004, 02:43 +0000 schrieb Matthew Garrett:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> >> Sorry, that's beyond my abilities. That's why I'm posting here. I'm not
> >> even sure that it's the radeon which is acting up here.
> > 
> > Have you tried with radeonfb in your kernel config ?
> 
> In the general case, it's harder to resume systems using framebuffers
> than systems that don't. The contortions that are necessary for non-fb
> systems tend to break fb systems (you end up with userspace and the
> kernel both trying to get the graphics hardware back into a sane state),
> so in an ideal world resume would work without any framebuffer support.

Trying to resume with radeonfb or X (DRI or fglrx) causes the machine
to freeze upon a resume.
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

