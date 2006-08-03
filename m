Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWHCVoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWHCVoY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWHCVoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:44:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24247
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932511AbWHCVoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:44:23 -0400
Date: Thu, 03 Aug 2006 14:43:37 -0700 (PDT)
Message-Id: <20060803.144337.34759358.davem@davemloft.net>
To: s0348365@sms.ed.ac.uk
Cc: rdunlap@xenotime.net, tytso@mit.edu, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       mchan@broadcom.com
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608031804.55292.s0348365@sms.ed.ac.uk>
References: <20060803163204.GB20603@thunk.org>
	<20060803094917.8280f5ff.rdunlap@xenotime.net>
	<200608031804.55292.s0348365@sms.ed.ac.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Date: Thu, 3 Aug 2006 18:04:55 +0100

> Probably. I have an NC6000 with a tg3 and have never experienced
> link failure problems, even under -rt.

And note that the "poke the chip N times a second to avoid lockup"
issue only matters on very very old tg3 chips.

Therefore I think Ted fixed his problem by accident, as very few
people in the world actually have tg3 chips old enough to need that
periodic poking.
