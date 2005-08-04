Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVHDAMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVHDAMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVHDAMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:12:20 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:62929 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261538AbVHDAMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:12:19 -0400
Subject: Re: BTTV - experimental no_overlay patch
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: 7eggert@gmx.de
Cc: Andrew Burgess <aab@cichlid.com>, LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <E1E0SGH-0000Zk-7Y@be1.lrz>
References: <4xiqy-2F3-5@gated-at.bofh.it>  <E1E0SGH-0000Zk-7Y@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 03 Aug 2005 21:06:40 -0300
Message-Id: <1123114000.8274.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo,

	Please, send me bttv init logs. I need to know if PCI quirks has
detected your PCI chipset as a problematic one.

Em Qui, 2005-08-04 às 01:02 +0200, Bodo Eggert escreveu:
> Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
> 
> > This small patch will allow no_overlay flag to disable BTTV driver to
> > report OVERLAY capabilities. It should fix your troubles by enabling
> > no_overlay=1 when inserting bttv module.
> > 
> > This patch is against our CVS tree, but should apply with some hunk on
> > 2.6.13-rc4 or 2.6.13-rc5.
> > 
> > I'll generate a new one at morning, against 2.6.13-rc5 hopefully to
> > have it applied at 2.6.13, since it fixes an OOPS.
> 
> The CVS line will off cause not apply, and I needed to change
> s/static// int no_overlay in bttv-cards.c.
	Strange. At CVS it worked even with static. But it should be ok. 
> 
> The picture is less distorted by pci activity with no_overlay=1, and it
> feels like the stable interface I used with my nvidia+2.4+XF86 before
> upgrading to 2.6+radeon+X.org. No OOPS within the first few minutes:).
	That's good!

Mauro.

