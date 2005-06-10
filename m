Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVFJOd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVFJOd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVFJOd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:33:57 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:22656
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S262563AbVFJOd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:33:56 -0400
Date: Fri, 10 Jun 2005 16:33:55 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050610143355.GE29454@erebor.esa.informatik.tu-darmstadt.de>
References: <20050605204645.A28422@jurassic.park.msu.ru> <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de> <20050606184335.A30338@jurassic.park.msu.ru> <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de> <20050609023639.A7067@jurassic.park.msu.ru> <1118289850.6850.164.camel@gaston> <20050609175441.C9187@jurassic.park.msu.ru> <20050609175429.GA26023@erebor.esa.informatik.tu-darmstadt.de> <20050609223835.GB26023@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 04:20:59PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 10 Jun 2005, Andreas Koch wrote:
> >
> > I did some more experimentation, and to my great the surprise, the
> > serial port on the dock _is_ functioning, even when the rest of the
> > dock is dead.

Note that, after further checking, I discovered that the very
low-speed ports on the dock (serial, PS/2, parallel) are _not_
interfaced via PCI Express (as the USB and FireWire ports are).  Thus,
the fact they do work does not help us in deducing the cause of the
bridging issues.

Andreas
