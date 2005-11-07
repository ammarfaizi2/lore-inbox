Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVKGWzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVKGWzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVKGWzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:55:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:61057 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964914AbVKGWzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:55:14 -0500
Date: Mon, 7 Nov 2005 14:53:08 -0800
From: Greg KH <greg@kroah.com>
To: linas <linas@austin.ibm.com>
Cc: linux-sparse@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7]: PCI revised (3) [PATCH 16/42]: PCI:  PCI Error reporting callbacks
Message-ID: <20051107225308.GB27787@kroah.com>
References: <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107195727.GF19593@austin.ibm.com> <20051107200352.GB22524@kroah.com> <20051107212128.GH19593@austin.ibm.com> <20051107213729.GA24700@kroah.com> <20051107224338.GQ19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107224338.GQ19593@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 04:43:38PM -0600, linas wrote:
> On Mon, Nov 07, 2005 at 01:37:29PM -0800, Greg KH was heard to remark:
> > On Mon, Nov 07, 2005 at 03:21:28PM -0600, linas wrote:
> > > +typedef int __bitwise pci_channel_state_t;
> > 
> > You don't have to use an enum anymore, just use a #define.
> 
> Per Linus's remarks about namespace pollution, I've kept the enums.

That's fine.

> > > +typedef int __bitwise pers_result_t;
> > 
> > You should at least keep "pci" at the beginning to make it make
> > more sense to people looking at it for the first time.
> 
> PCI_ERS and pci_ers, then.

Sounds good.

> I'm feeling like a blinkin' spammer, splatting out all these emails.

Care to just resend the whole series over again?  No "patch on top of
patch" stuff is needed here.

thanks,

greg k-h
