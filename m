Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVDFXvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVDFXvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 19:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVDFXvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 19:51:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:7891 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262354AbVDFXvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 19:51:53 -0400
Subject: Re: [linux-usb-devel] USB glitches after suspend on ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <200504061628.05527.david-b@pacbell.net>
References: <20050405204449.5ab0cdea@jack.colino.net>
	 <200504061311.53720.david-b@pacbell.net> <1112828577.9568.199.camel@gaston>
	 <200504061628.05527.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 09:50:56 +1000
Message-Id: <1112831456.9568.217.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 16:28 -0700, David Brownell wrote:
> On Wednesday 06 April 2005 4:02 pm, Benjamin Herrenschmidt wrote:
> > 
> > > Thanks for the testing update.  I'm glad to know that there seems to
> > > be only one (minor) glitch that's PPC-specific!
> > 
> > Which is just an off-the-shelves NEC EHCI chip.
> 
> The wakeup-after-suspend hasn't been reported by anyone else.

Looks like the root hub is set for triggering wakeups on connect, isn't
that just a setting in there ? The old Apple ASIC had a bit somewhere to
control that, but I don't know about the NEC

Ben.


