Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWGRGeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWGRGeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 02:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWGRGeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 02:34:13 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:41888 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751313AbWGRGeN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 02:34:13 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-usb-devel] [PATCH] Add USB to MPC8349 PB platform support
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 18 Jul 2006 14:34:29 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0509A9@zch01exm20.fsl.freescale.net>
In-Reply-To: <200607171557.50368.david-b@pacbell.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] [PATCH] Add USB to MPC8349 PB platform support
Thread-Index: Acap9HJvMt3Nw9ATTV+ueBQLsgC9EAAP2LjQ
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "David Brownell" <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Cc: "Hollis Blanchard" <hollis@penguinppc.org>,
       "Kumar Gala" <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Tuesday, July 18, 2006 6:58 AM
> To: linux-usb-devel@lists.sourceforge.net
> Cc: Hollis Blanchard; Kumar Gala; linuxppc-dev@ozlabs.org; Li
Yang-r58472
> Subject: Re: [linux-usb-devel] [PATCH] Add USB to MPC8349 PB platform
support
> 
> On Monday 17 July 2006 1:08 pm, Hollis Blanchard wrote:
> >
> > Seems to me that it's far better to have init code in the kernel
than
> > firmware.
> 
> If there's a general Linux policy on the issue, I think that'd be it.

Do we have a general policy for this now?
> 
> Plus, remember that boot firmware _can't_ always be changed/bugfixed;
> sometimes it can, but not as a general rule.
> 
> - Dave
> 
> 
> > For one example, look at the x86 video card init problem
> > PowerPC Linux has. It's also far easier to fix/deploy Linux code
than
> > firmware code, as Li observed, and on top of that it's less work for
> > non-UBoot firmwares in the future.
> >
> > -Hollis
> >
