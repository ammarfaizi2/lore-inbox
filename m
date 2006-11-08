Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754515AbWKHK6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbWKHK6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbWKHK6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:58:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:32131 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1754515AbWKHK6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:58:02 -0500
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 08 Nov 2006 11:58:00 +0100
From: "Marco Schwarz" <marco.schwarz@gmx.net>
Message-ID: <20061108105800.69650@gmx.net>
MIME-Version: 1.0
Subject: IP: kernel level autoconfig broken in 2.6.18.2 ? 
To: linux-kernel@vger.kernel.org
X-Authenticated: #12086198
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have been trying to set up network booting with Kernel 2.6.18.2 and have the problem that IP: kernel level autoconfig seems not to work, I tried both DHCP and BOOTP.

I cannot see any dhcp or bootp requests beeing issued to my dhcp server except the initial one by the network card. When autoconfig should happen (the card is recognised, and the driver loaded), the kernel prints the following:

IP-Config: Guessing netmask 255.0.0.0
IP-Config: Complete:
  device=eth0, addr=10.110.169.221, mask=255.0.0.0, gw=255.255.255.255,
  host=10.110.169.221, domain=, nis-domain=(none),
  bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
Root-NFS: No NFS server available, giving up

10.110.169.221 is my servers address, the client should get .116, but as I said no BOOTP od DHCP request is sent ...

Best regards,
Marco Schwarz
