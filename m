Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVLCJw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVLCJw0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 04:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVLCJw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 04:52:26 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:10665 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1751046AbVLCJwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 04:52:25 -0500
Date: Sat, 3 Dec 2005 10:52:20 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3C905C-TX
Message-ID: <20051203095220.GA31216@merlin.emma.line.org>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
References: <eab8d9e30511300459j695ed942n@mail.gmail.com> <Pine.LNX.4.61.0511300813190.18193@chaos.analogic.com> <9a8748490511300602u2cf9f972od6617b8fe777bd9a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a8748490511300602u2cf9f972od6617b8fe777bd9a@mail.gmail.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2005, Jesper Juhl wrote:

> On 11/30/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
> >
> > On Wed, 30 Nov 2005, [iso-8859-1] Daniel Höhnle wrote:
> >
> > > Hello i have Suse Linux 9.3 and a 3Com 3C905C-TX Networkcard. But she
> > > don't works. Where can I get a Driver??? Or give it a Dokumentation
> > > how I can make the Driver??
> > >
> > > Thanks
> > > Daniel Höhnle
> >
> > The 3c59x driver should work for this device. If it's real
> > new, you may have to add its ID to the structure at line
> > 3365 in 3x59x.c or contact the maintainer.
> >
> The 3c90x driver available from 3COM themselves is another alternative
> : http://support.3com.com/infodeli/tools/nic/linuxdownload.htm

At that site, there are apparently no 3Com drivers for 2.6 kernels (SUSE
9.3 uses 2.6.11.something IIRC), 3Com link to Donald Becker's driver
<http://www.scyld.com/vortex.html> instead.

SUSE ships with the 3c59x driver (no big surprise, it's in the kernel
baseline), and this works with all 3C90X cards I've ever used (Boomerang
and Tornado series) with SUSE Linux.

SUSE Linux has no problems either with configuring this card through
YaST's LAN module, and the process is described in detail, with
screenshots, in the administration manual (chapter 22.4).

-- 
Matthias Andree
