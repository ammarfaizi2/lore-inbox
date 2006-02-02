Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWBBXxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWBBXxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWBBXxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:53:40 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:28679 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S932486AbWBBXxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:53:39 -0500
Message-Id: <20060202233909.426660000@lorien.sirena.org.uk>
Date: Thu, 02 Feb 2006 23:27:26 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 0/2] natsemi: NAPI and a bugfix
X-Spam-Score: -2.5 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  These patches provide a series of updates to the
	natsemi driver: the NAPI patch I've submitted before and a workaround
	for an issue with the hardware that is easier to provoke at higher data
	rates. 1/2: Convert the driver to NAPI 2/2: Fix hardware issue with RX
	state machine lock up [...] 
	Content analysis details:   (-2.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches provide a series of updates to the natsemi driver: the
NAPI patch I've submitted before and a workaround for an issue with the
hardware that is easier to provoke at higher data rates.

  1/2: Convert the driver to NAPI
  2/2: Fix hardware issue with RX state machine lock up

--
"You grabbed my hand and we fell into it, like a daydream - or a fever."
