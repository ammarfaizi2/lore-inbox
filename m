Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273141AbRJKHBq>; Thu, 11 Oct 2001 03:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273349AbRJKHBf>; Thu, 11 Oct 2001 03:01:35 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:6416 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S273141AbRJKHBT>; Thu, 11 Oct 2001 03:01:19 -0400
Subject: Re: Linux 2.4.10-ac11
From: Miles Lane <miles@megapathdsl.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Alan Cox <laughing@shared-source.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20011010203004.E11147@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk> 
	<20011010203004.E11147@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99 (Preview Release)
Date: 10 Oct 2001 23:52:48 -0700
Message-Id: <1002783189.1357.130.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-10 at 20:30, Tom Rini wrote:
> Hello.  In updating the PPC defconfigs, I noticed that
> drivers/usb/Config.in will ask questions on machines where CONFIG_PCI=n
> but CONFIG_EXPERIMENTAL=y.  The following puts all of the USB items
> under the if [ "$CONFIG_USB" = "y" -o "$CONFIG_USB" = "m" ] check and
> fixes some spacing bits.

Do we really still think USB deserves the Experimental label?
I use it all the time and it seems about as solid as any of
the other subsystems.  I know drivers continue to evolve, get
bugs fixed and new ones get added, but is that a good reason
to mark all USB support experimental?

Just wondering what the criteria are,

	Miles

