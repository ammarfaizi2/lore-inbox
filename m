Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269943AbUJNB2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269943AbUJNB2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 21:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269944AbUJNB2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 21:28:18 -0400
Received: from science.horizon.com ([192.35.100.1]:19761 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S269943AbUJNB1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 21:27:55 -0400
Date: 14 Oct 2004 01:27:54 -0000
Message-ID: <20041014012754.25198.qmail@science.horizon.com>
From: linux@horizon.com
To: stockall@magma.ca
Subject: Re: Clock inaccuracy seen on NVIDIA nForce2 systems
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The system is running 2.6.9-rc4 and has been up for 2 days. I'm showing
> an offset of -32 seconds and growing.

That's -185 ppm (parts per million) error, or -0.0185%.

Typical cheap quartz crystals are +/- 100 ppm, but there are some cheaper
than that, and ceramic resonators like
http://www.ecsxtal.com/cerares.htm

I know Dave Mills learned from experience that the original +/-100 ppm
specs in NTP weren't wide enough and he had to change it to cope with
+/-500 ppm error in some clocks.

It *could* just be your motherboard's clock source.
