Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276453AbRJKPBL>; Thu, 11 Oct 2001 11:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276457AbRJKPBC>; Thu, 11 Oct 2001 11:01:02 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:4013 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S276453AbRJKPAu>; Thu, 11 Oct 2001 11:00:50 -0400
Date: Thu, 11 Oct 2001 08:01:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Miles Lane <miles@megapathdsl.net>
Cc: Alan Cox <laughing@shared-source.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-ac11
Message-ID: <20011011080117.D12016@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk> <20011010203004.E11147@cpe-24-221-152-185.az.sprintbbd.net> <1002783189.1357.130.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002783189.1357.130.camel@stomata.megapathdsl.net>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 11:52:48PM -0700, Miles Lane wrote:
> On Wed, 2001-10-10 at 20:30, Tom Rini wrote:
> > Hello.  In updating the PPC defconfigs, I noticed that
> > drivers/usb/Config.in will ask questions on machines where CONFIG_PCI=n
> > but CONFIG_EXPERIMENTAL=y.  The following puts all of the USB items
> > under the if [ "$CONFIG_USB" = "y" -o "$CONFIG_USB" = "m" ] check and
> > fixes some spacing bits.
> 
> Do we really still think USB deserves the Experimental label?

Not experimental but some of the USB drivers.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
