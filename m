Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbULRLA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbULRLA1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 06:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbULRLA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 06:00:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5358 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262102AbULRLAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 06:00:21 -0500
Date: Sat, 18 Dec 2004 12:00:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Charles-Henri Collin <charlie.collin@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip=dhcp problem...
In-Reply-To: <41C40326.3070303@free.fr>
Message-ID: <Pine.LNX.4.61.0412181159580.28067@yvahk01.tjqt.qr>
References: <41C40326.3070303@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I've got the following problem with linux 2.6.8.1:
> I'm nfs-rooting a diskless client with kernel parameter ip=dhcp.
> My dhcpd.conf  has a "option domain-name-servers X.X.X.X;" statement and
> "get-lease-hostnames true;"
> Now when the diskless clients boot, no name-server configured and they cant
> resolv.
> dmesg gives me, for instance:

What happens if you put
	option domain-name-servers 192.168.222.1;
in your dhcpd.conf, i.e. an IP number rather than a host?




Jan Engelhardt
-- 
ENOSPC
