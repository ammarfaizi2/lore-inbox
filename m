Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbUCNMaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 07:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263352AbUCNMaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 07:30:21 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:41888 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263350AbUCNMaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 07:30:18 -0500
Date: Sun, 14 Mar 2004 13:30:14 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: bcm5700  driver at 100Mbit? tg3 doesn't do 100Mbit - 2.6.4-mm1
Message-ID: <20040314123014.GA8839@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4053F511.1070607@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4053F511.1070607@blueyonder.co.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004, Sid Boyce wrote:

> tg3.ko loads, network starts up. Can't connect to 100Mbit network 
> switch. The bcm5700 driver in ths SuSE kraxel 2.6.3 kernel works. The 
> tg3  is supposed to be a replacement for bcm5700 I believe.

On Debian's 2.4, I have been able to get 100 Mbps traffic by forcing a
re-negotiation through mii-diag or ethtool (I don't recall which one,
this mii-tool/mii-diag/ethtool is a HORRIBLE MESS that needs to be
sorted out) and seem to recall that ifconfig eth0 down ; ifconfig eth1
up could also have fixed this - however, such behaviour is of course
unsuitable for production use and I don't know if the same trick works
on 2.6 kernels.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
