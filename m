Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUFIWUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUFIWUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUFIWUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:20:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2019 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265981AbUFIWUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:20:43 -0400
Date: Wed, 9 Jun 2004 15:12:46 -0700
From: "David S. Miller" <davem@redhat.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: davidsen@tmr.com, jgarzik@pobox.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
Message-Id: <20040609151246.1c28c4d9.davem@redhat.com>
In-Reply-To: <20040609213850.GA17243@k3.hellgate.ch>
References: <20040607212804.GA17012@k3.hellgate.ch>
	<20040607145723.41da5783.davem@redhat.com>
	<20040608210809.GA10542@k3.hellgate.ch>
	<40C77C70.5070409@tmr.com>
	<20040609213850.GA17243@k3.hellgate.ch>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004 23:38:50 +0200
Roger Luethi <rl@hellgate.ch> wrote:

> <sigh> I just killed the module parameters in my via-rhine development
> tree.

That is absolutely the correct thing to do, module parameters for
link settings are %100 deprecated, people need to use ethtool for
everything.
