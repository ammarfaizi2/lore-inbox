Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752102AbWCCIBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbWCCIBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 03:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbWCCIBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 03:01:23 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:9606 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S1752102AbWCCIBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 03:01:22 -0500
From: Marc Zyngier <maz@misterjones.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Rick Richardson <rick@remotepoint.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] EISA: tidy-up driver_register() return value
Organization: Metropolis -- Nowhere
References: <200603021617.55396.bjorn.helgaas@hp.com>
X-Attribution: maz
Reply-to: maz@misterjones.org
Date: Fri, 03 Mar 2006 09:00:55 +0100
Message-ID: <wrpmzg83qko.fsf@wild-wind.fr.eu.org>
In-Reply-To: <200603021617.55396.bjorn.helgaas@hp.com> (Bjorn Helgaas's
	message of "Thu, 2 Mar 2006 16:17:55 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 192.168.70.139
X-SA-Exim-Rcpt-To: bjorn.helgaas@hp.com, rick@remotepoint.com, linux-kernel@vger.kernel.org, akpm@osdl.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on young-lust.wild-wind.fr.eu.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bjorn" == Bjorn Helgaas <bjorn.helgaas@hp.com> writes:

Bjorn> Remove the assumption that driver_register() returns the number
Bjorn> of devices bound to the driver.  In fact, it returns zero for
Bjorn> success or a negative error value.

Bjorn> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Looks ok to me.

Acked-by: Marc Zyngier <maz@misterjones.org>

	M.
-- 
And if you don't know where you're going, any road will take you there...
