Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbVKWKr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbVKWKr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 05:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbVKWKr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 05:47:27 -0500
Received: from [81.2.110.250] ([81.2.110.250]:62443 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030394AbVKWKr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 05:47:26 -0500
Subject: Re: Christmas list for the kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910511221558o4eb493cdhfef81e632c5306e7@mail.gmail.com>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <1132702505.20233.88.camel@localhost.localdomain>
	 <9e4733910511221558o4eb493cdhfef81e632c5306e7@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Nov 2005 11:19:53 +0000
Message-Id: <1132744793.7268.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 18:58 -0500, Jon Smirl wrote:
> On 11/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Maw, 2005-11-22 at 16:13 -0500, Jon Smirl wrote:
> > > All of the legacy stuff - VGA, Vesafb, PS2, serial, parallel,
> >
> > PCI Parallel and serial hotplug
> > PS2 hotplugs if you've got hotpluggable PS2 - I've even used this
> > Most Joysticks hotplug
> > Gameports mostly hotplug
> > VESAfb is by definition not hotplug capable
> > VGA hotplug we don't do but you can load the module.
> 
> The devices that plug into the ports hotplug, but the existence of the
> ports themselves does not autodetect/hotplug at boot time.

Untrue for PS2 ports, most modern joystick (old joystick has not
hotplug) and VGA. Also untrue for serial/parallel IFF your udev scripts
are right.

