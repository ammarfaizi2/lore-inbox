Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbVJ0WUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbVJ0WUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbVJ0WUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:20:22 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:12229
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1751587AbVJ0WUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:20:21 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: Marcel Holtmann <marcel@holtmann.org>, Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Date: Thu, 27 Oct 2005 18:20:20 -0400
Message-Id: <20051027221756.M55421@linuxwireless.org>
In-Reply-To: <1130451421.5416.35.camel@blade>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade> <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade> <20051027211203.M33358@linuxwireless.org> <20051027220533.GA18773@redhat.com> <1130451071.5416.32.camel@blade> <20051027221253.GA25932@redhat.com> <1130451421.5416.35.camel@blade>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005 00:17:01 +0200, Marcel Holtmann wrote
> Hi Dave,
> 
> >  > > Some boards at least have a BIOS option to support 'memory hoisting'
> >  > > to map the 'lost' memory above the 4G address space.
> >  > > 
> >  > > I suspect a lot of the lower-end (and older) boards however don't have
> >  > > this option, as they were not tested with 4GB.
> >  > 
> >  > do you have any information about remapping support of the D945GNT
> >  > motherboard from Intel.
> > 
> > I've not come across an EM64T with that much RAM, so I've not had
> > reason to go looking.. Sorry.
> 
> am I really the first person trying to use that board with 4 GB of 
> RAM and an Intel Dual-Core with EM64T :(

Dude, again. This has nothing to do with the CPU. The arch IA32 is simply
_not_ made for 4GB, so, some motherboards manufacturers make a workaround like
Dave said, to Map such RAM. After all, that 0.6GB RAM will be used and
allocated for other resources. This is just how the arch works and I doubt it
will change.

Only thing that you can do is buy a new Mobo which might support Mapping for
the extra RAM.

There isn't really much that you can do.

.Alejandro

