Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269574AbUICJRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269574AbUICJRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbUICJOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:14:44 -0400
Received: from sv3.70009.ip.nltree.nl ([213.34.28.242]:19521 "EHLO
	exchange-test.office.zx.nl") by vger.kernel.org with ESMTP
	id S269464AbUICJNw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.orG>);
	Fri, 3 Sep 2004 05:13:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.4.27 e1000 driver and keepalived
Date: Fri, 3 Sep 2004 11:13:29 +0200
Message-ID: <1A231876B7149843A53D220337C84A0075DF35@exchange-test.office.zx.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.27 e1000 driver and keepalived
Thread-Index: AcSRlkYqchUlJrZsSo625K0JNa9knw==
From: "Dennis Kruyt" <d.kruyt@zx.nl>
To: <linux-kernel@vger.kernel.orG>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
After I upgrade to kernel 2.4.27 from 2.4.25 I get the following error
in the syslog from keepalived:
 
Sep  1 09:18:39 cas-lb2 Keepalived: Watchdog: Error connecting
/tmp/.vrrp wdog socket
 
And when I downgrade again to 2.4.25 the error is gone and keepalived
works a before.
 
I am using the e1000 driver for my network card's. I have also
backported the e1000 driver from kernel 2.4.27 to 2.4.25 and then I got
the same error there.
 
So my conclusion is that the e1000 driver from 2.4.27 doesn't work with
keepalived 1.1.7
 
2.4.25: Intel(R) PRO/1000 Network Driver - version 5.2.20-k1 2.4.27
:Intel(R) PRO/1000 Network Driver - version 5.2.52-k3 <- doesn't work
with keepalived 1.1.7
 
Has some one the same problems and is there a fix?
 
Regards,
 
Dennis
