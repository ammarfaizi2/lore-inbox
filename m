Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVIUAOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVIUAOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVIUAOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:14:22 -0400
Received: from mail20.bluewin.ch ([195.186.19.65]:7093 "EHLO mail20.bluewin.ch")
	by vger.kernel.org with ESMTP id S1750754AbVIUAOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:14:22 -0400
Date: Tue, 20 Sep 2005 20:03:41 -0400
To: Matt LaPlante <laplam@rpi.edu>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Unknown symbol in crc32c in 2.6.13.1
Message-ID: <20050921000341.GA2527@mars>
References: <200509200507.j8K57kY6006302@ms-smtp-03-eri0.southeast.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509200507.j8K57kY6006302@ms-smtp-03-eri0.southeast.rr.com>
User-Agent: Mutt/1.5.9i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 01:07:42AM -0400, Matt LaPlante wrote:
> Hi All,
>   I see this error repeatedly.  Running Debian latest stable branch w/
> custom 2.6.13.1 kernel.  I've got the racoon package installed and I'm
> running IPSec between two such gateways.  On both ends, when I start Racoon
> for my IPSec link I always get the following error:
> 
> ###################################################
> firewall:~# /etc/init.d/racoon restart
> Stopping IKE (ISAKMP/Oakley) server: racoon.
> Flushing SAD and SPD...
> SAD and SPD flushed.
> Unloading IPSEC/crypto modules...
> IPSEC/crypto modules unloaded.
> Loading IPSEC/crypto modules...
> 
> insmod: error inserting
> '/lib/modules/2.6.13.1-firewall/kernel/crypto/crc32c.ko': -1 Unknown symbol
> in module
> 
> 
> IPSEC/crypto modules loaded.
> Starting IKE (ISAKMP/Oakley) server: racoon.
> Flushing SAD and SPD...
> SAD and SPD flushed.
> Loading SAD and SPD...
> SAD and SPD loaded.
> Configuring racoon...done.
> ###################################################
> 
> It doesn't seem to be fatal, but I figured I'd report it since it seems to
> be continuous.  Syslog gives only the following:
> 
> Sep 20 00:58:53 localhost kernel: crc32c: Unknown symbol crc32c_le

Hmmm.

> I hope this problem isn't considered too trivial to report...sorry if I'm
> wasting your time with it.
 
Could you please post a copy of your .config and /etc/init.d/racoon.
Thanks.

	Arthur
