Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263442AbTC2RQi>; Sat, 29 Mar 2003 12:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263443AbTC2RQi>; Sat, 29 Mar 2003 12:16:38 -0500
Received: from franka.aracnet.com ([216.99.193.44]:50083 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263442AbTC2RQh>; Sat, 29 Mar 2003 12:16:37 -0500
Date: Sat, 29 Mar 2003 09:27:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 519] New: unregister_netdevice: waiting for eth0 to become
 free. Usage count = 0 
Message-ID: <59300000.1048958872@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=519

           Summary: unregister_netdevice: waiting for eth0 to become free.
                    Usage count = 0
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: jgarzik@pobox.com
         Submitter: jochen@jochen.org


Distribution: Debian sarge
Hardware Environment: IBM Thinkpad 600, PCMCIA card with pcnet_cs driver

Problem Description:

I get the message when shutting down.  When removing the card, usage count
is 2. This earlier message may be related:
__ipv6_regen_rndid(): too short regeneration interval; timer diabled for
eth0.

Steps to reproduce:

shutdown with "init 0" or remove the card when configured.

