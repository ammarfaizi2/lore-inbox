Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTFFRDk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 13:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTFFRDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 13:03:40 -0400
Received: from wks1.stratum8.com ([64.186.168.130]:28947 "EHLO
	sd-exchange.sdesigns.com") by vger.kernel.org with ESMTP
	id S262115AbTFFRDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 13:03:37 -0400
Message-ID: <9F77D654ED40B74CA79E5A60B97A087B07C313@sd-exchange.sdesigns.com>
From: Ho Lee <Ho_Lee@sdesigns.com>
To: "'Stephan von Krawczynski'" <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: How to turn off ide dma ...
Date: Fri, 6 Jun 2003 10:22:52 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ide=nodma option would help you. It disables DMA on every
IDE interfaces. 

Regards,
Ho

-----Original Message-----
From: Stephan von Krawczynski [mailto:skraw@ithnet.com]
Sent: Friday, June 06, 2003 5:25 AM
To: linux-kernel
Subject: How to turn off ide dma ...


for certain devices as boot-option in kernel 2.4.20 ?

E.g. you have three devices and want one of them (not all) to come up PIO
instead of DMA.
As using hdparm gives errors and delays for about 20-30 seconds on this
device
it would be better to turn it off right from the beginning.

Regards,
Stephan
