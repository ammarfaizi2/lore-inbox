Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTI1XNL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbTI1XNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:13:10 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:59653 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262775AbTI1XNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:13:09 -0400
Date: Sun, 28 Sep 2003 20:18:42 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: netdev@oss.sgi.com, davem@redhat.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030928231842.GE1039@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, netdev@oss.sgi.com, davem@redhat.com,
	pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030928225941.GW15338@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928225941.GW15338@fs.tum.de>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 29, 2003 at 12:59:41AM +0200, Adrian Bunk escreveu:
> It seems modular IPv6 doesn't work 100% reliable, e.g. after looking at 
> the code it doesn't seem to be a good idea to compile a kernel without 
> IPv6 support and later build and install IPv6 modules. Is there a great 
> need for modular IPv6 or is the patch below to disallow modular IPv6 OK?

Please, don't... We're going in the all modules direction, not the other
way around, distro (general purpose) kernels would get big bloat in the
static kernel.

- Arnaldo
