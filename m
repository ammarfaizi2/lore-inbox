Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUIUUHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUIUUHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268043AbUIUUHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:07:53 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:21896
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268048AbUIUUHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:07:03 -0400
Date: Tue, 21 Sep 2004 12:56:45 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: herbert@gondor.apana.org.au, paul@clubi.ie, alan@lxorguk.ukuu.org.uk,
       vph@iki.fi, toon@hout.vanvergehaald.nl, admin@wolfpaw.net,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)
 Denial of Service Attack
Message-Id: <20040921125645.05fafd5a.davem@davemloft.net>
In-Reply-To: <873c1bjwwj.fsf@deneb.enyo.de>
References: <E1C9aB6-0007Gk-00@gondolin.me.apana.org.au>
	<873c1bjwwj.fsf@deneb.enyo.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004 20:32:12 +0200
Florian Weimer <fw@deneb.enyo.de> wrote:

> > But then you get PMTU problems...
> 
> PMTU discovery is not an issue because it's turned off anyway, at
> least by default.

It's on by default, for both TCP and UDP in the kernel,
and has been so for a long time.

Why would it be off by default?

If you disable PMTU discovery, say goodbye to TCP
performance.
