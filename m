Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVLRKsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVLRKsD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 05:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVLRKsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 05:48:03 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:30679 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S965081AbVLRKsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 05:48:03 -0500
From: Stefan Rompf <stefan@loplof.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Sun, 18 Dec 2005 11:49:01 +0100
User-Agent: KMail/1.8
Cc: Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512181149.02009.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Kernel code is getting more complex all the time and running with
> very tight stack is just risky.

Btw., has anyone yet *measured* maximum stack usage for some weeks on several 
machines, e.g. desktop system with one NIC, reiserfs; server with several 
NICs, stacked device-mapper targets, fiber channel, appletalk...; web server 
with SQL database running on it etc?

Right now I have the impression that the 4k stack flamewars base on make 
checkstack output, waiting for bugreports and other guesswork. Removing the 
safety net on such a basis is just *very bad engineering*.

Stefan
