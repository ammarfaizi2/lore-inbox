Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422861AbWBNXAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422861AbWBNXAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbWBNXAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:00:32 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:27404 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1422861AbWBNXAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:00:31 -0500
Date: Wed, 15 Feb 2006 00:00:23 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060214230023.GA66586@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg KH <greg@kroah.com>,
	ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
	linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <20060213175046.GA20952@kroah.com> <20060213195322.GB89006@dspnet.fr.eu.org> <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060214104003.GA97714@dspnet.fr.eu.org> <20060214222428.GA357@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214222428.GA357@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 02:24:28PM -0800, Greg KH wrote:
> Because if you have to have udev push the names back into the kernel,
> why not just ask udev in the first place what they were?

Because there is no reason to think udev of 2008 will be compatible
with today's udev given udev's history.  And that's provided udev is
still in use at that time.


> Again, use HAL, not udev for this stuff.  FC3 is also out of date for
> lots of things becides udev, so why refer to it?

Because it proves you don't give a shit about backwards compatibility.
There are a lot of fc3 installations out there still.  And I'm sure
there are other distributions besides that one that made the mistake
to trust the udev developers to respect the compatibility implicit
contract.

At that point Hal is *not* considered stable interface-wise by its own
developpers, so using it for anything that's supposed to stay working
for a while is *stupid*.  When they decide it's 1.0 time, we'll talk.
Even *dbus* is not 1.0 yet in large part for interface stabilization
reasons.

  OG.
