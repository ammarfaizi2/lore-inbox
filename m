Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWAVNfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWAVNfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 08:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWAVNfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 08:35:15 -0500
Received: from smile.2scale.net ([212.12.33.142]:5274 "EHLO smile.2scale.net")
	by vger.kernel.org with ESMTP id S1751223AbWAVNfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 08:35:14 -0500
Subject: Re: 2.6.16_rc1 psmouse hangs without KVM
From: Michael Stiller <ms@2scale.net>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000601200838s702db8c6p4bbc6924dcebe6c1@mail.gmail.com>
References: <43D10CA9.4030307@inode.at>
	 <d120d5000601200838s702db8c6p4bbc6924dcebe6c1@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 14:35:15 +0100
Message-Id: <1137936915.5572.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O>
> > Since the change from 2.6.14 to 2.6.16_rc1, I got mouse hangs using a
> > first-generation MS IntelliEye Explorer with USB->PS2 converter, no KVM,
> > which ran smoothly on the official 2.6.14.
> >
> >
> > The syslog message is ...
> >
> >   psmouse.c: resync failed, issuing reconnect request
> >
> > and I have the exact symptoms - hang after about 10 sec mouse
> > inactivity, then after 2 secs it's back to normal - as described in the
> > thread ...

I guess i may have related symptoms on 2.6.13-2.6.15.1.

During disk io (eg sorting you inbox with evolution) i get :

psmouse.c: TrackPoint at isa0060/serio1/input0 lost synchronization,
throwing 2 bytes away.

The system reacts very sluggish, in fact it is completly unusable.

There are also issues with the keyboard subsystem at that times.

-Michael

