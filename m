Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTI2A05 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 20:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTI2A04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 20:26:56 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:22278 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261940AbTI2A0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 20:26:55 -0400
Date: Sun, 28 Sep 2003 21:32:30 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: netdev@oss.sgi.com, davem@redhat.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030929003229.GM1039@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, netdev@oss.sgi.com, davem@redhat.com,
	pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030928225941.GW15338@fs.tum.de> <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de> <20030928233909.GG1039@conectiva.com.br> <20030929001439.GY15338@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929001439.GY15338@fs.tum.de>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 29, 2003 at 02:14:39AM +0200, Adrian Bunk escreveu:
> On Sun, Sep 28, 2003 at 08:39:10PM -0300, Arnaldo Carvalho de Melo wrote:
> What about the following solution (the names and help texts for the
> config options might not be optimal, I hope you understand the
> intention):
> 
> config IPV6_SUPPORT
> 	bool "IPv6 support"
> 
> config IPV6_ENABLE
> 	tristate "enable IPv6"
> 	depends on IPV6_SUPPORT
> 
> IPV6_SUPPORT changes structs etc. and IPV6_ENABLE is responsible for 
> ipv6.o .

Humm, and the idea is? This seems confusing, could you elaborate on why such
scheme is a good thing?

- Arnaldo
