Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVL2Qzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVL2Qzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbVL2Qzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:55:43 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:17084
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750862AbVL2Qzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:55:43 -0500
Message-ID: <43B41509.1000507@microgate.com>
Date: Thu, 29 Dec 2005 10:55:37 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Burkhard_Sch=F6lpen?= <bschoelpen@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA burst delay
References: <395603262@web.de>
In-Reply-To: <395603262@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burkhard Schölpen wrote:
> why I cannot get longer bursts than 512 Bits...

What value is written by the system into the
PCI configuration space of your device for
the latency timer?
(8 bits at offset 0x0d, units = clock cycles)

You can try setting that value in your
driver to a higher value.

-- 
Paul Fulghum
Microgate Systems, Ltd.
