Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUIUTym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUIUTym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUIUTyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:54:41 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:10120
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268031AbUIUTye convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:54:34 -0400
Date: Tue, 21 Sep 2004 12:54:06 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RARP support disapeard in kernel 2.6.x ?
Message-Id: <20040921125406.3d768d48.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.60L.0409212019090.15099@rudy.mif.pg.gda.pl>
References: <Pine.LNX.4.44.0409211359270.5322-100000@localhost.localdomain>
	<Pine.LNX.4.44.0409211359270.5322-100000@localhost.localdomain>
	<Pine.LNX.4.60L.0409211511290.15099@rudy.mif.pg.gda.pl>
	<cipqh4$g9d$1@gatekeeper.tmr.com>
	<Pine.LNX.4.60L.0409212019090.15099@rudy.mif.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004 20:28:13 +0200 (CEST)
Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl> wrote:

> rarp from old net-tools still try to open /proc/net/rarp and depending on
> not avalaibability this file prints above message.

You're not supposed to use the 'rarp' tool to configure
the rarpd daemon, you're supposed to use configuration files
such as /etc/ethers to configure it.
