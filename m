Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbTI1Xm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbTI1Xm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:42:28 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:5638 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262868AbTI1XmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:42:24 -0400
Date: Sun, 28 Sep 2003 20:47:58 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>, netdev@oss.sgi.com, davem@redhat.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030928234757.GI1039@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, netdev@oss.sgi.com, davem@redhat.com,
	pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030928225941.GW15338@fs.tum.de> <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de> <20030928233909.GG1039@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928233909.GG1039@conectiva.com.br>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 28, 2003 at 08:39:10PM -0300, Arnaldo C. Melo escreveu:
> Simply removing the ifdefs in the headers will not help, leaving it in the
> kernel will bloat general purpose kernels, so can we live with this limitation

s/leaving it in the kernel/making it always statically linked in the kernel if
selected/g

Sorry...

- Arnaldo
