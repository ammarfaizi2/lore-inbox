Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbTHTLeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 07:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbTHTLeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 07:34:11 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:37852 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261896AbTHTLeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 07:34:08 -0400
Date: Wed, 20 Aug 2003 13:34:06 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [2.4.2X] "Undeletable" ARP entries?
Message-ID: <20030820113406.GA12023@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
References: <20030820113208.GA11163@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030820113208.GA11163@merlin.emma.line.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    SuSE 2.4.20 kernel for 8.2 (k_athlon-2.4.20-96)
> or 2.4.22-rc2-ac1

...

> WORKAROUND:

This workaround will only work on 2.4.22-rc2-ac1, but not on SuSE's
2.4.20 kernel. -ac bug?

> $ ip addr add 192.168.4.4 dev eth1
> $ ip addr del 192.168.4.4 dev eth1
> 
> Now the arp entry is gone, probably as a side effect of taking down
> resources related to 192.168.4.4.
> HOWEVER: the ARP entry was supposed to be permanent, so it may be
> another bug that the entry is gone after removing an IP alias.
> 
> Anyone got ideas or patches to try?
> 
