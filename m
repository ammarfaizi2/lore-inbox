Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751944AbWI3Uea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbWI3Uea (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWI3Uea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:34:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:41363 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751944AbWI3Ue3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:34:29 -0400
From: Andi Kleen <ak@suse.de>
To: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [2.6.18-git] Lost all PCI devices
Date: Sat, 30 Sep 2006 22:34:24 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060930174247.GA31793@dreamland.darkstar.lan> <200609302011.13457.ak@suse.de> <20060930202240.GA15952@dreamland.darkstar.lan>
In-Reply-To: <20060930202240.GA15952@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609302234.24778.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 September 2006 22:22, Luca Tettamanti wrote:
> Il Sat, Sep 30, 2006 at 08:11:13PM +0200, Andi Kleen ha scritto: 
> > On Saturday 30 September 2006 19:42, Luca Tettamanti wrote:
> > > Hi Andi,
> > > I'm testing current git on my notebook, but kernel doesn't find any
> > > PCI device: no video card, no IDE, nothing.
> > 
> > Can you test it with this patch please?
> 
> Works fine, I can boot with it. Thank you!

Just curious - i assume you have CONFIG_PCI_GOBIOS set. Does your system
also work when you set CONFIG_PCI_GODIRECT instead?

-Andi
