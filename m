Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264678AbTGKRxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264730AbTGKRwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:52:23 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:15340 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S264722AbTGKRvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:51:45 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [RFC] KBUILD 2.5 issues/regressions
Date: Fri, 11 Jul 2003 19:06:33 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <200307111840.31225.alistair@devzero.co.uk> <200307111856.53635.alistair@devzero.co.uk> <20030711180134.H19709@devserv.devel.redhat.com>
In-Reply-To: <20030711180134.H19709@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307111906.33747.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 July 2003 19:01, Arjan van de Ven wrote:
> On Fri, Jul 11, 2003 at 06:56:53PM +0100, Alistair J Strachan wrote:
> > On Friday 11 July 2003 18:47, Arjan van de Ven wrote:
> > > On Fri, 2003-07-11 at 19:40, Alistair J Strachan wrote:
> > > > o The state of kbuild in shipped (distribution) kernels must be such
> > > > that the construction of external modules can be done without having
> > > > to modify the shipped kernel-source package.
> > >
> > > that is actually not hard; I just did this in a RH rpm like way last
> > > week.
> >
> > I cannot see how you can make modversions modules without first building
> > vmlinux. This "RPM" presumably does not ship with vmlinux constructed
>
> It does actually.

Ah. In that case, I suppose it's all moot and won't end up being an issue. It 
just strikes me that vmlinux would not have to be included in a distro 2.4 
kernel, because it is not a "dependency" of the build system. If this is how 
distros will operate, then just forget about it.

>
> > Try it with the NVIDIA driver
>
> no think you I prefer not to touch that with a 10 foot pole

Interesting snip of my original sentence.

Cheers,
Alistair.
