Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbTD2MlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbTD2MlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:41:13 -0400
Received: from net049s.hetnet.nl ([194.151.104.184]:19464 "EHLO hetnet.nl")
	by vger.kernel.org with ESMTP id S261857AbTD2MlM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:41:12 -0400
Content-Class: urn:content-classes:message
From: <bas.mevissen@hetnet.nl>
To: "Martin List-Petersen" <martin@list-petersen.dk>,
       "David S. Miller" <davem@redhat.com>
Cc: <bas.mevissen@hetnet.nl>, <linux-kernel@vger.kernel.org>
Subject: RE: Broadcom BCM4306/BCM2050  support
Date: Tue, 29 Apr 2003 14:51:12 +0200
Message-ID: <4b4e01c30e4e$0352c5a0$d16897c2@hetnet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft CDO for Windows 2000
Thread-Index: AcMOTgNSONr+6Ho7EdeYPABQi7AS7A==
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David S. Miller wrote:

> Don't expect specs or opensource drivers for any of these pieces
> of hardware until these vendors figure out a way to hide the frequency
> programming interface.

What did Intersil do? How did the linux-wlan-ng project handle this?

> The only halfway plausible idea I've seen is to not document the
> frequency programming registers, and users get a "region" key file that
> has opaque register values to program into the appropriate registers.
> The file is per-region (one for US, Germany, etc.)and the wireless
> kernel driver reads in this file to do the frequency programming.

Here in The Netherlands, it is quite common to use a US version of Windows and to keep (most of)  the regional settings of the US. So on Windows, most of the time the region is likely to be wrong. I gues that in cases where things are critical, a different firmware version is used. 

It is not really a practical problem however, because the allowed frequencies have become pretty the same over time. The same applies to modems: they are also country-specific. But in practice, it is not really a concern.

But how to go furter with this? Does someone have contacts within Broadcom?

Regards,

Bas.



--------------------------------------------------------------------------------
