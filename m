Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTFEEc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 00:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTFEEc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 00:32:27 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.92.226.49]:57755 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S264393AbTFEEc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 00:32:26 -0400
Date: Thu, 5 Jun 2003 00:45:57 -0400
From: Dan Maas <dmaas@maasdigital.com>
To: linux-kernel@vger.kernel.org
Subject: Alpha hang after 24hrs (2.4.21-rc6)
Message-ID: <20030605004557.A22504@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Info: http://www.maasdigital.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my Alpha EV56 PC164 system from kernel 2.2.25 to
2.4.21-rc6. With the newer kernel the system hangs reliably after
roughly 24 hours of uptime.

Normally I would suspect heat or RAM failure, but the system seems to
work fine with the older kernel. 

The symptom is a total lock-up/freeze, nothing is printed to the
console or syslog. I have not tried a serial console yet but that is
my next step.

The system is a stock 1-CPU 500MHz Alpha, 128MB RAM, nothing special,
just two 3c59x ethernet cards and an AIC788x SCSI controller. It
functions as a web server and NAT gateway. Most of the time it is just
idle. The only unusual thing in the 2.4 kernel configuration is that
I'm using the new QoS packet filtering options (for wondershaper).

This machine has served me reliably for years, and I'd hate to see it
go down for good ;). I really do need the new QoS stuff in 2.4 though.

Any ideas? Please CC to me.

Thanks,
Dan
