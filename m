Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTKGAwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 19:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTKGAwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 19:52:54 -0500
Received: from mailrelay.yorku.ca ([130.63.236.144]:22689 "EHLO
	sungoddess.ccs.yorku.ca") by vger.kernel.org with ESMTP
	id S261271AbTKGAww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 19:52:52 -0500
Subject: New MSI USB device won't accept address
From: Austin <aacton@yorku.ca>
Reply-To: aacton@yorku.ca
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: GNU Linux
Message-Id: <1068166362.2328.6.camel@gamma373-179.portable.resnet.yorku.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-9mdk 
Date: Thu, 06 Nov 2003 19:52:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried this device out for fun, although I would really like to
use it.  It's a USB 802.11b interface, UB11B (MS-6823).  I tried it on
three VERY different motherboards, both with 2.4.22 and 2.6test8
kernels: exact same error, so I'm pretty sure it's specific to this
device.

Nov  6 19:36:38 gamma373-179 kernel: hub 2-0:1.0: new USB device on port
1, assigned address 2
Nov  6 19:36:38 gamma373-179 kernel: [deb94240] link (1eb941e2) element
(016bc080)
Nov  6 19:36:38 gamma373-179 kernel:  Element != First TD
Nov  6 19:36:38 gamma373-179 kernel:   0: [c16bc040] link (016bc080) e3
Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=1c61d4e0)
Nov  6 19:36:38 gamma373-179 kernel:   1: [c16bc080] link (00000001) e3
IOC Stalled Babble Length=7ff MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN)
(buf=00000000)
Nov  6 19:36:38 gamma373-179 kernel:
Nov  6 19:36:39 gamma373-179 kernel: [deb94240] link (1eb941e2) element
(016bc040)
Nov  6 19:36:39 gamma373-179 kernel:   0: [c16bc040] link (016bc080) e0
Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP)
(buf=1c61d4e0)
Nov  6 19:36:39 gamma373-179 kernel:   1: [c16bc080] link (00000001) e3
IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN)
(buf=00000000)
Nov  6 19:36:39 gamma373-179 kernel:
Nov  6 19:36:39 gamma373-179 kernel: usb 2-1: device not accepting
address 2, error -110

Device info here:
http://www.msicomputer.com/product/detail_spec/product_detail.asp?model=UB11B

Unfortunately it doesn't specify the chipset anywhere in the
documentation.

Please CC me if you need any more information or a sample of the windows
driver or the hardware.

Thanks for your help, 
Austin
-- 
                                 Austin Acton
        Synthetic Organic Chemist, Teaching Assistant, Ph.D. Candidate
               Department of Chemistry, York University, Toronto
        MandrakeLinux Volunteer Developer, homepage: www.groundstate.ca


