Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTELAfC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTELAfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:35:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17121 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261678AbTELAfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:35:00 -0400
Message-ID: <3EBEEF38.1070008@pobox.com>
Date: Sun, 11 May 2003 20:47:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: eth0: Too much work in interrupt, status e401
References: <1052699512.662.3.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1052699512.662.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> Hi!
> 
> I'm having severe hardlocks with 2.5.69-mm3 when mounting an NFS volume
> from one of my NFS servers. I think this is related to iptables, but
> while investigating, I found the following messages on my dmesg ring:
> 
> spurious 8259A interrupt: IRQ7.
> eth0: Setting full-duplex based on MII #0 link partner capability of
> 01e1.
> eth0: Transmit error, Tx status register 90.


Check out REPORTING-BUGS file in the kernel source code.  It describes 
the information we find useful in bug reports.  In particularly, you did 
not give us any information on your network hardware (network card, and 
what it is connected to) or what drivers you have loaded.

	Jeff



