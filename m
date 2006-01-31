Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWAaU40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWAaU40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWAaU40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:56:26 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:23957 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751399AbWAaU4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:56:25 -0500
Subject: Re: R: Xorg  crashes 2.6.16-rc1-git4
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Mauro Tassinari <mtassinari@cmanet.it>
Cc: linux-kernel@vger.kernel.org, airlied@linux.ie
In-Reply-To: <1138740690.22358.11.camel@localhost>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAATCL5fQYOzEifgaWohcVWWwEAAAAA@cmanet.it>
	 <1138740690.22358.11.camel@localhost>
Date: Tue, 31 Jan 2006 22:56:23 +0200
Message-Id: <1138740983.22358.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Tue, 2006-01-31 at 21:34 +0100, Mauro Tassinari wrote:
> > in both cases, no kernel video module was loaded. 
> > Hope this helps a bit, thank you for your attention.

On Tue, 2006-01-31 at 22:51 +0200, Pekka Enberg wrote:
> Does disabling CONFIG_DRM_RADEON fix the hard lock? You have compiled
> Radeon DRM as module so I think X will try to load it at start-up.

Seems likely as others are having problems with RV370 as well:

https://bugs.freedesktop.org/show_bug.cgi?id=5341

			Pekka

