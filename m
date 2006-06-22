Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWFVBcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWFVBcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWFVBcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:32:25 -0400
Received: from mx.pathscale.com ([64.160.42.68]:13780 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030480AbWFVBcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:32:24 -0400
Date: Wed, 21 Jun 2006 18:32:22 -0700
From: Greg Lindahl <greg.lindahl@qlogic.com>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, Dave Olson <olson@unixfolk.com>,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, discuss@x86-64.org
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilitiesKJ
Message-ID: <20060622013222.GF2614@greglaptop.internal.keyresearch.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Jeff Garzik <jeff@garzik.org>, Dave Olson <olson@unixfolk.com>,
	Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
	gregkh@suse.de, discuss@x86-64.org
References: <DBFABB80F7FD3143A911F9E6CFD477B00E48CF12@hqemmail02.nvidia.com> <p73vequomc8.fsf@verdi.suse.de> <Pine.LNX.4.61.0606210920170.30013@osa.unixfolk.com> <200606211837.30056.ak@suse.de> <20060622012339.GD2614@greglaptop.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622012339.GD2614@greglaptop.internal.keyresearch.com>
User-Agent: Mutt/1.4.1i
X-Frumious: Bandersnatch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 06:37:30PM +0200, Andi Kleen wrote:

> Because I don't think normal Linux users should be in the hardware validation
> business. If the vendor says it's not tested we shouldn't enable it by default.

All you're going to do is piss off all the distros and hardare vendors
shipping systems with this chip in it. Nvidia is not the only "vendor"
involved, and is not the only one doing hardware validation. Sun, HP,
Newisys, and LNXI all have currently shipping Opteron products with a
CK804.  All 4 are probably going to want your employer's distro to not
disable MSI.

-- greg
