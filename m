Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVAMVwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVAMVwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVAMVwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:52:06 -0500
Received: from colin2.muc.de ([193.149.48.15]:9733 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261730AbVAMVuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:50:46 -0500
Date: 13 Jan 2005 22:50:44 +0100
Date: Thu, 13 Jan 2005 22:50:44 +0100
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050113215044.GA1504@muc.de>
References: <41E2AC74.9090904@us.ibm.com> <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com> <1105454259.15794.7.camel@localhost.localdomain> <20050111173332.GA17077@muc.de> <1105626399.4664.7.camel@localhost.localdomain> <20050113180347.GB17600@muc.de> <1105641991.4664.73.camel@localhost.localdomain> <20050113202354.GA67143@muc.de> <1105645491.4624.114.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105645491.4624.114.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 07:44:52PM +0000, Alan Cox wrote:
> On Iau, 2005-01-13 at 20:23, Andi Kleen wrote:
> > > X needs to be able to find the device layout in order to build its PCI
> > > mappings. Cached data is probably quite sufficient for this.
> > 
> > I mean i would expect it to continue scanning other entries when it sees
> > an error on one.  Is that not true?
> 
> X needs to be able to find the device layout in order to build its PCI
> mappings. If there are things mysteriously vanishing now and then its
> not going to have valid mappings

I could see it as a problem when it happens on a bridge, but why
should it be a problem when some arbitary, nothing to do with X
leaf is temporarily not available? 

-Andi
