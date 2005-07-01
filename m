Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263165AbVGABlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbVGABlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 21:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbVGABlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 21:41:25 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:41994 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S263165AbVGABlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 21:41:21 -0400
Date: Thu, 30 Jun 2005 21:41:00 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Greg KH <greg@kroah.com>
Cc: linux-pm <linux-pm@lists.osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] firmware leaves device in D3hot at boot
Message-ID: <20050701014056.GA13710@tuxdriver.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-pm <linux-pm@lists.osdl.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20050623191451.GA20572@tuxdriver.com> <20050624022807.GF28077@tuxdriver.com> <20050630171010.GD11369@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630171010.GD11369@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 10:10:10AM -0700, Greg KH wrote:
> On Thu, Jun 23, 2005 at 10:28:07PM -0400, John W. Linville wrote:
> > On Thu, Jun 23, 2005 at 03:14:52PM -0400, John W. Linville wrote:
> > 
> > > This issue regarding D3hot->D0 state transitions seems like a piece
> > > of minutiae that we should not force individual drivers to address.
> > 
> > After some thought, I'm inclined to think that the patch below is
> > the right one.  It unconditionally saves and restores the PCI config
 
> But how does this solve your problem with the state change?

Please ignore the previous patches.  I've had some good feedback
from Russell King and Adam Belay, and I have reformulated the patch
accordingly.  I will be posting that shortly.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
