Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWBBLCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWBBLCP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWBBLCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:02:15 -0500
Received: from ns.firmix.at ([62.141.48.66]:24714 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750724AbWBBLCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:02:14 -0500
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
From: Bernd Petrovitsch <bernd@firmix.at>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Jiri Slaby <xslaby@fi.muni.cz>,
       kavitha s <wellspringkavitha@yahoo.co.in>, linux-kernel@vger.kernel.org
In-Reply-To: <20060202091900.469e7394@werewolf.auna.net>
References: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
	 <Pine.LNX.4.61.0602011713410.22529@yvahk01.tjqt.qr>
	 <1138810616.16643.30.camel@tara.firmix.at>
	 <1138863107.3270.8.camel@laptopd505.fenrus.org>
	 <20060202091900.469e7394@werewolf.auna.net>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 02 Feb 2006 11:55:28 +0100
Message-Id: <1138877728.12822.5.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 09:19 +0100, J.A. Magallon wrote:
> On Thu, 02 Feb 2006 07:51:47 +0100, Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > On Wed, 2006-02-01 at 17:16 +0100, Bernd Petrovitsch wrote:
> > > On Wed, 2006-02-01 at 17:14 +0100, Jan Engelhardt wrote:
> > > [...]
> > > > >change root=LABEL=/ to root=/dev/XXX. Vanilla doesn't support this...
> > > > >
> > > > is there a kernel patch that does allow it?
> > > 
> > > Yes, in RedHat's/Fedora's kernels since ages.
> > 
> > wrong.
> > there is NO kernel patch for this. Not in RHs and not in Fedora's
> > kernel.
> > Never was either.
> > it's 100% done in the initrd.

Oooops, sorry.
s/RedHat's\/Fedora's kernels/RedHa\/Fedora/

> Isn't this a matter of the bootloader ?

No, because it is merely used as a kernel parameter (which led me to the
false conclusion that it is done within the kernel) and the kernel
either mounts the root filesystem (without initrd) or it is handled
within the initrd (if you have one).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

