Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263711AbUESLWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUESLWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUESLVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:21:20 -0400
Received: from ns.clanhk.org ([69.93.101.154]:4026 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S263664AbUESLSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:18:44 -0400
Message-ID: <40AB42D4.5010704@clanhk.org>
Date: Wed, 19 May 2004 06:19:48 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] eepro100 vs e100?
References: <200405190858.44632.lkml@kcore.org>
In-Reply-To: <200405190858.44632.lkml@kcore.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've always had good results with the e100 driver:

Intel(R) PRO/100 Network Driver - version 2.3.36-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth1: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Jan De Luyck wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Hello List,
>
>I'm currently in the process of cleaning up my 2.6 kernel configuration on my 
>trusty SMP HP Netserver LC3, which comes shipped with 2 identical intel Pro 
>Ethernet 100 mbit cards:
>
>0000:00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
>(rev 05)
>        Subsystem: Hewlett-Packard Company NetServer 10/100TX
>        Flags: bus master, medium devsel, latency 66, IRQ 16
>        Memory at fecfd000 (32-bit, prefetchable)
>        I/O ports at fcc0 [size=32]
>        Memory at fed00000 (32-bit, non-prefetchable) [size=1M]
>        Capabilities: [dc] Power Management version 1
>
>I'm wondering what driver is the "best" one to use? Judging by the comments in 
>the files, the e100 driver seems to be the best maintained, though I'm 
>probably wrong ;p
>
>The website that is referenced in the eepro100 driver is no longer available 
>(returns a 404).
>
>If someone can shed some light on this, thanks!
>
>Jan
>- -- 
>Sanity is the trademark of a weak mind.
>		-- Mark Harrold
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.4 (GNU/Linux)
>
>iD8DBQFAqwWhUQQOfidJUwQRAt7wAJ9H/wapw68XfrYHgV44tf4MfqIUeACdFBvF
>R4Aupx+q9AlCKEWjtAE2v2c=
>=jQHj
>-----END PGP SIGNATURE-----
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

