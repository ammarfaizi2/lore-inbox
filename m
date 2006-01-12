Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161235AbWALUHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161235AbWALUHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161241AbWALUHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:07:48 -0500
Received: from mtaout4.012.net.il ([84.95.2.10]:8943 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S1161235AbWALUHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:07:46 -0500
Date: Thu, 12 Jan 2006 22:07:35 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
In-reply-to: <43C6ADDE.5060904@liberouter.org>
To: Jiri Slaby <slaby@liberouter.org>
Cc: Jon Mason <jdmason@us.ibm.com>, linux-kernel@vger.kernel.org
Message-id: <20060112200735.GD5399@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060112175051.GA17539@us.ibm.com>
 <43C6ADDE.5060904@liberouter.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 08:28:30PM +0100, Jiri Slaby wrote:

> You should change alsa driver (sound/pci/trident/trident.c), rather than this,
> which will be removed soon, I guess. And, additionally, could you change that
> lines to use PCI_DEVICE macro?

This driver is not up for removal soon, as it supports a device that
the alsa driver apparently doesn't (the INTERG_5050). As for
PCI_DEVICE, agreed. Jon, feel like patching it up?

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

