Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268734AbUIXNL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268734AbUIXNL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 09:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268720AbUIXNL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 09:11:56 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:27818 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S268734AbUIXNLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 09:11:37 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [Pcihpd-discuss] Re: Is there a user space pci rescan method?
Date: Fri, 24 Sep 2004 15:18:43 +0200
User-Agent: KMail/1.7
Cc: Jan Dittmer <jdittmer@ppp0.net>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <41541009.9080206@ppp0.net> <20040924130935.GB16153@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040924130935.GB16153@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241518.44496@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 24. September 2004 15:09 schrieb Matthew Wilcox:
> On Fri, Sep 24, 2004 at 02:16:09PM +0200, Jan Dittmer wrote:
> > My point was, I load dummyphp with showunused=0 and only get dirs for the
> > slots with devices in them. Now I decide to put a network card (or
> > whatever I have to spare) in an empty slot, hope that the system doesn't
> > reboot immediately, and voila I don't have any /sys/bus/pci/slots dir to
> > enable the slot and have to reboot nevertheless. Or does the pci system a
> > rescan if I reinsert the module?
>
> That is DANGEROUS and WILL DESTROY YOUR SYSTEM.  Under no circumstances
> should we be encouraging people to do that.

Yes, and that's why there a big comments as well in the Kconfig help as well 
as in the source of both dummyphp and fakephp.

Eike
