Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTFPMda (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 08:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTFPMd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 08:33:29 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:22992 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261825AbTFPMd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 08:33:29 -0400
Date: Mon, 16 Jun 2003 14:47:15 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: BUG REPORT: Massive performance drop in routing throughput with
 2.4.21
In-Reply-To: <20030616141806.6a92f839.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.51.0306161444090.18129@dns.toxicfilms.tv>
References: <20030616141806.6a92f839.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> there seems to be a real serious problem with 2.4.21, routing through two
> ethernet-devices. After 24 hours of a routing-only box the throughput from
> ethernet a to ethernet b decreased to something around 4-100 kByte/sec (100
> Mbit network 2 cards ns83820). I had to drop using 2.4.21 on this box because
> of this. 2.4.20 is flawless on the machine and ran for around 100 days before
> without any troubles. Going back to 2.4.20 cured it.
Are you using any netfilter patch-o-matic patches?
Does it also affect eg. ssh latency even on LAN ?

Since I switched my processor from Intel do Amd, I have been experiencing
similar but after longer periods of time than yours.

I am also using VIA chipset, maybe it's a hardware driver problem.

Regards,
Maciej

