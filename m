Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTJQTew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbTJQTew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:34:52 -0400
Received: from web14911.mail.yahoo.com ([216.136.225.249]:23394 "HELO
	web14911.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263593AbTJQTes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:34:48 -0400
Message-ID: <20031017193447.41865.qmail@web14911.mail.yahoo.com>
Date: Fri, 17 Oct 2003 12:34:47 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
To: James Simmons <jsimmons@infradead.org>, Otto Solares <solca@guug.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310171751200.966-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The people writing the AGP driver have added their ID's in the wrong format.
ATI wants the IDs in the two letter form, not family/chip.  The fbdev patch has
the ID's in correct form. The AGP driver should be the one that gets changed.

--- James Simmons <jsimmons@infradead.org> wrote:
> 
> > - Could I2C be ported to kernel I2C api and separated?, so it use would not
> > require the fbdev module loaded.
> 
> I don't think that can be done. At least not easily.
>  
> > - PCI IDs list should be in pci_ids.h as every other drivers, reality is
> > that adding new IDs to pci_ids.h is not hard so your driver will not be the
> > exception to the rule.
> 
> I agree here. We do need to watch out for the AGP drivers. Changing PCI 
> Id's can break them. I dicovered that recently.
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
> The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
> Linux in the Boardroom; in the Front Office; & in the Server Room 
> http://www.enterpriselinuxforum.com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
