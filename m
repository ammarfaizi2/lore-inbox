Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVACTiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVACTiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVACTiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:38:16 -0500
Received: from smtpout3.compass.net.nz ([203.97.97.135]:8674 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S261530AbVACTiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:38:15 -0500
Date: Tue, 4 Jan 2005 08:38:22 +1300 (NZDT)
From: steve@perfectpc.co.nz
X-X-Sender: sk@localhost
Reply-To: steve@perfectpc.co.nz
To: Phil Oester <kernel@linuxace.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: iptable_nat: Unknown symbol need_ip_conntrack
In-Reply-To: <20050103050001.GA12500@linuxace.com>
Message-ID: <Pine.LNX.4.60.0501040830080.1409@localhost>
References: <Pine.LNX.4.60.0501031641250.32415@localhost>
 <20050103050001.GA12500@linuxace.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Kernel 2.6.10-ac2 . Apart from this, the system appears to be normal;
>
> Looks like a problem with your configuration/kernel build...I have no
> such problems here on 2.6.10.

Me too, on the other two machine doesn't have ; only the firewall box has. It seems
to be related to iproute2 or MARK target? as only the firewall box uses 
iptables to mark packets and then use iproute2 to route it.

I am pretty sure the config and kernel build are correct.

I will try to find out how to reproduce the problem with the other two machine I have here
