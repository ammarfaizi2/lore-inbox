Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbVLRMGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbVLRMGI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 07:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVLRMGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 07:06:08 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:33929 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932696AbVLRMGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 07:06:07 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stefan Rompf <stefan@loplof.de>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <200512181149.02009.stefan@loplof.de>
References: <200512181149.02009.stefan@loplof.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Dec 2005 12:06:24 +0000
Message-Id: <1134907584.26141.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-12-18 at 11:49 +0100, Stefan Rompf wrote:
> Btw., has anyone yet *measured* maximum stack usage for some weeks on several 
> machines, e.g. desktop system with one NIC, reiserfs; server with several 
> NICs, stacked device-mapper targets, fiber channel, appletalk...; web server 
> with SQL database running on it etc?

Some vendors have shipped distributions configured with 4K stacks for a
long time and monitored bug reports. 
