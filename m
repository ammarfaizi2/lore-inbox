Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270628AbTGNNE2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270627AbTGNNEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:04:21 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:52402 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S270628AbTGNNCV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:02:21 -0400
To: "Frantisek =?iso-8859-1?q?Rys=E1nek?=" <rysanek@fccps.cz>
Cc: <marcelo@conectiva.com.br>, "Francois Romieu" <romieu@fr.zoreil.com>,
       <henrique2.gobbi@cyclades.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
References: <20030711212551.A25528@electric-eye.fr.zoreil.com>
	<002a01c349fc$23a0e8c0$ec00000a@fccps.cz>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 14 Jul 2003 15:16:59 +0200
In-Reply-To: <002a01c349fc$23a0e8c0$ec00000a@fccps.cz>
Message-ID: <m3y8z1b644.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Frantisek Rysánek" <rysanek@fccps.cz> writes:

> As for the userspace sethdlc.c by Krzystof Halasa: I was using ver.1.12,
> modified by Mr. Romieu, who has "cut some non-compiling functionality."

It was a q&d version to support Ethernet emulation and did not compile
without it. Was in the README in fact.

> The current version from Krzysztof Halasa is 1.15.

This one doesn't have this problem, Ethernet emulation doesn't get
compiled if the kernel has no support for it.

> Specifically, I was using uniprocessor machines only (no SMP).

This is a common problem. From time to time I perform SMP tests, but they
are neither extensive or long-term :-(

> I've written a short mini-HOWTO - the chapter on test results in terms of
> transfer rates and ping round trips is at
> http://sweb.cz/Frantisek.Rysanek/sync/dscc4+HDLC-Mini-HOWTO.html#Drivers.ope
> n.tests

Looks nice, that's something I always wanted to have... I'll send you
an errata.
Great job.
-- 
Krzysztof Halasa
Network Administrator
