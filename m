Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVFVPV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVFVPV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVFVPRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:17:24 -0400
Received: from gw.alcove.fr ([81.80.245.157]:13245 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261497AbVFVPLp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:11:45 -0400
Subject: Re: [linux-usb-devel] Re: usb sysfs intf files no longer created
	when probe fails
From: Stelian Pop <stelian@popies.net>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050622145948.GA1883@kroah.com>
References: <1119448257.4587.2.camel@localhost.localdomain>
	 <20050622145948.GA1883@kroah.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 22 Jun 2005 17:09:23 +0200
Message-Id: <1119452963.4787.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 22 juin 2005 à 07:59 -0700, Greg KH a écrit :
> On Wed, Jun 22, 2005 at 03:50:56PM +0200, Stelian Pop wrote:
> > I use the 'atp' input driver from http://popies.net/atp/ to drive this
> > touchpad. When removing the driver I also get an oops, possibly related
> > to the previous failure to create the sysfs file:
> 
> Sounds like a bug in that driver, care to ask the authors of it about
> this?

I am the author :)

That driver worked until yesterday, and I was not able to find out about
any API change which would disrupt it now, that's why I reported this to
the list... 

Stelian.
-- 
Stelian Pop <stelian@popies.net>

