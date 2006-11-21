Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030712AbWKURJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030712AbWKURJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031222AbWKURJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:09:37 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:64150 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030712AbWKURJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:09:36 -0500
Message-ID: <456332D3.50404@drzeus.cx>
Date: Tue, 21 Nov 2006 18:09:39 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: kernel list <linux-kernel@vger.kernel.org>,
       Fabio Comolli <fabio.comolli@gmail.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] MMC: new version of the TI Flash Media card reader
 driver
References: <183693.25832.qm@web36707.mail.mud.yahoo.com>
In-Reply-To: <183693.25832.qm@web36707.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> The substantial rewrite of the driver addresses following issues:
> 1. Logic error with multi-block writes fixed
> 2. Suspend/resume should now work as expected in all cases (more testing
> may be needed)
> 3. Hardware timeout setup corrected
> 4. Per-socket workqueues replaced by one kthread + tasklets
> 5. Device with pci id 104C:AC8F is now recognized as supported

Separate these please. The patch is simply too big to make sense out of.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
