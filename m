Return-Path: <linux-kernel-owner+w=401wt.eu-S1750850AbXAOPcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbXAOPcR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 10:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbXAOPcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 10:32:17 -0500
Received: from bill.weihenstephan.org ([82.135.35.21]:39163 "EHLO
	bill.weihenstephan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbXAOPcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 10:32:16 -0500
From: Juergen Beisert <juergen127@kreuzholzen.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: how to combine PCI and platform device in one driver
Date: Mon, 15 Jan 2007 16:32:12 +0100
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701151632.12920.juergen127@kreuzholzen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is there any "standard" way to handle _one_ function in _one_ driver where the 
hardware is divided into something like a platform device (some registers are 
fixed in the chipset) and a PCI part? To bring the function up, registers in 
both parts must be programmed and they depend on each other.
Will this driver be more a PCI driver or more a platform driver?
Or is it possible to add the platform like resources to the PCI list of 
resources of my PCI device (to handle it as a PCI device only)?

Regards
Juergen
