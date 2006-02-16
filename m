Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWBPAKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWBPAKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 19:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWBPAKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 19:10:55 -0500
Received: from shamrock.dyndns.org ([213.146.117.139]:26117 "EHLO
	shamrock.taprogge.wh") by vger.kernel.org with ESMTP
	id S1750825AbWBPAKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 19:10:54 -0500
Date: Thu, 16 Feb 2006 01:10:56 +0100
From: Jens Taprogge <jlt_lk@shamrock.dyndns.org>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netfilter@lists.netfilter.org
Subject: 2.6.16-rc3 panic related to IP Forwarding and/or Netfilter
Message-ID: <20060216001056.GA7446@ranger.taprogge.wh>
Mail-Followup-To: Jens Taprogge <jlt_lk@shamrock.dyndns.org>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netfilter@lists.netfilter.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

After upgrading from 2.6.13 an IP Masquerading router panics as soon as
soon as packages are forwarder (or rather should be).  As long as IP
Masquerading is disabled (and thus no forwarding occurs) the box runs
stable.

A picture of the panic ouput can be found at:
http://shamrock.dyndns.org/~ln/kernel/2.6.16rc3_panic/panic.jpg
The config is at:
http://shamrock.dyndns.org/~ln/kernel/2.6.16rc3_panic/config-2.6.16-rc3-g51d6aa16-dirty

The kernel was patched to support SIP-contrack however the extra files
have not been compiled and should thus have no influence.

Please cc me on replies as I am not subscribed to the lists.

Best Regards
Jens Taprogge
