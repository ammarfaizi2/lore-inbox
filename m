Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTFPMiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 08:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTFPMiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 08:38:09 -0400
Received: from mail.ithnet.com ([217.64.64.8]:8718 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262456AbTFPMiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 08:38:06 -0400
Date: Mon, 16 Jun 2003 14:51:35 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: Massive performance drop in routing throughput with
 2.4.21
Message-Id: <20030616145135.0ef5c436.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.51.0306161444090.18129@dns.toxicfilms.tv>
References: <20030616141806.6a92f839.skraw@ithnet.com>
	<Pine.LNX.4.51.0306161444090.18129@dns.toxicfilms.tv>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003 14:47:15 +0200 (CEST)
Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:

> > there seems to be a real serious problem with 2.4.21, routing through two
> > ethernet-devices. After 24 hours of a routing-only box the throughput from
> > ethernet a to ethernet b decreased to something around 4-100 kByte/sec (100
> > Mbit network 2 cards ns83820). I had to drop using 2.4.21 on this box
> > because of this. 2.4.20 is flawless on the machine and ran for around 100
> > days before without any troubles. Going back to 2.4.20 cured it.
> Are you using any netfilter patch-o-matic patches?

No.

> Does it also affect eg. ssh latency even on LAN ?

Not very seriously.

> Since I switched my processor from Intel do Amd, I have been experiencing
> similar but after longer periods of time than yours.
> 
> I am also using VIA chipset, maybe it's a hardware driver problem.

No, my two boxes have differing mb's. One is VIA, the other is Intel440BX.

But I can also verify that the problem arises with 2.4.21-rc7, too. I guess it
is effectively an older problem that has not been recognised so far.

> Regards,
> Maciej

Regards,
Stephan

