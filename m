Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTFOSXN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTFOSXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:23:13 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:27316 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262530AbTFOSXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:23:08 -0400
Subject: Re: 2.4.20: MASQ firewall is losing TCP sessions [tcpdumped]
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: insecure@mail.od.ua, vda@port.imtp.ilyichevsk.odessa.ua
Cc: netfilter-devel@lists.samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <200306152055.45490.insecure@mail.od.ua>
References: <200306152055.45490.insecure@mail.od.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055702217.3214.10.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Jun 2003 20:36:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-15 at 19:55, insecure wrote:

> Looks like firewall forgot about our connection. What's going on?
> 
> Kernel: 2.4.20, .config is at the end of this mail.

Kernel 2.4.20 has a very serious problem with ip_conntrack.
It has been corrected in 2.4.21 so please upgrade.

> I'd be happy to provide more info on known connections and the like,
> but I failed to find an iptables equivalent of ipchains -M. :(

cat /proc/net/ip_conntrack

Upgrade to 2.4.21, if that doesn't work you can provide more info.

-- 
/Martin
