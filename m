Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264073AbUESG6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUESG6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 02:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbUESG6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 02:58:30 -0400
Received: from dialpool2-121.dial.tijd.com ([62.112.11.121]:47489 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S264073AbUESG6N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 02:58:13 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.6] eepro100 vs e100?
Date: Wed, 19 May 2004 08:58:39 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405190858.44632.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello List,

I'm currently in the process of cleaning up my 2.6 kernel configuration on my 
trusty SMP HP Netserver LC3, which comes shipped with 2 identical intel Pro 
Ethernet 100 mbit cards:

0000:00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 05)
        Subsystem: Hewlett-Packard Company NetServer 10/100TX
        Flags: bus master, medium devsel, latency 66, IRQ 16
        Memory at fecfd000 (32-bit, prefetchable)
        I/O ports at fcc0 [size=32]
        Memory at fed00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 1

I'm wondering what driver is the "best" one to use? Judging by the comments in 
the files, the e100 driver seems to be the best maintained, though I'm 
probably wrong ;p

The website that is referenced in the eepro100 driver is no longer available 
(returns a 404).

If someone can shed some light on this, thanks!

Jan
- -- 
Sanity is the trademark of a weak mind.
		-- Mark Harrold
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqwWhUQQOfidJUwQRAt7wAJ9H/wapw68XfrYHgV44tf4MfqIUeACdFBvF
R4Aupx+q9AlCKEWjtAE2v2c=
=jQHj
-----END PGP SIGNATURE-----
