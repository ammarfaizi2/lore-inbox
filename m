Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRKNRf0>; Wed, 14 Nov 2001 12:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276988AbRKNRfQ>; Wed, 14 Nov 2001 12:35:16 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:21632
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S276708AbRKNRfC>; Wed, 14 Nov 2001 12:35:02 -0500
Date: Wed, 14 Nov 2001 12:33:14 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML 1.8.4 is available
Message-ID: <20011114123314.A1978@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011113175010.A15716@thyrsus.com> <20011113182718.A1630@kroah.com> <20011114123325.A500@thyrsus.com> <20011114100020.A5287@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011114100020.A5287@kroah.com>; from greg@kroah.com on Wed, Nov 14, 2001 at 10:00:21AM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com>:
> > Historical reasons.  My rulebase was opriginally one big file for editing
> > conveniece.  What directory whould the USB serial stuff live in?
> 
> drivers/usb/serial
> 
> > > There doesn't seem to be any rules set up for drivers/hotplug.
> > 
> > What symbols should be in there,
> 
> CONFIG_HOTPLUG_PCI
> CONFIG_HOTPLUG_PCI_COMPAQ
> CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM
> 
> See the Config.in file in that directory for the dependencies they have
> on each other.

OK, this wiull be in 1.8.6.  I'm going to have to figure out why my coverage 
tools didn't catch those three symbols.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Where rights secured by the Constitution are involved, there can be no
rule making or legislation which would abrogate them.
        -- Miranda vs. Arizona, 384 US 436 p. 491
