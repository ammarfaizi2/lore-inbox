Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWJ3Q3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWJ3Q3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWJ3Q3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:29:53 -0500
Received: from rosi.naasa.net ([212.8.0.13]:4760 "EHLO rosi.naasa.net")
	by vger.kernel.org with ESMTP id S965015AbWJ3Q3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:29:52 -0500
From: Joerg Platte <lists@naasa.net>
Reply-To: jplatte@naasa.net
To: linux-kernel@vger.kernel.org
Subject: IPSEC and bridged interfaces
Date: Mon, 30 Oct 2006 17:29:48 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200610301729.49089.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

currently I'm using kernel 2.6.18.1 on one of my computers. The router acts as 
an ipsec endpoint and masquerades all packets received via IPSEC.

Today I replaced the local ethernet interface by a bridged interface by 
combining the ethernet interface with a tap interface. I changed the 
interface names in my iptables-based firewall to match the new bridge 
interface name and did not change anything else.

Unfortunately, the kernel does not encrypt incoming packages any more. tcpdump 
reveals, that all received replies (I tested it with ping) are forwarded 
unencrypted, because they are visible on my firewall instead of being 
encrypted. Is this a known problem? Is bridging and IPSEC (maybe with 
masquerading) currently not supported? Or should I forward this issue to 
another mailing list? 

regards,
Jörg

