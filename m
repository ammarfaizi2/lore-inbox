Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVDHEZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVDHEZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVDHEZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 00:25:08 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:25729
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262685AbVDHEZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 00:25:04 -0400
Date: Thu, 7 Apr 2005 21:22:19 -0700
From: "David S. Miller" <davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: herbert@gondor.apana.org.au, akpm@osdl.org, guillaume.thouvenin@bull.net,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-Id: <20050407212219.7009000b.davem@davemloft.net>
In-Reply-To: <1112932354.28858.192.camel@uganda>
References: <E1DJjiR-000850-00@gondolin.me.apana.org.au>
	<1112931238.28858.180.camel@uganda>
	<20050408033246.GA31344@gondor.apana.org.au>
	<1112932354.28858.192.camel@uganda>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Apr 2005 07:52:34 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> sparc64 has 32->64 conversation on exit.

It's extremely cheap, the conversion instruction
pairs with the retl instruction so it's essentially
free.

Talking about an arithmetic instruction over is complete
nonsense when the atomic CAS instruction itself takes a minimum
of 32 processor cycles :-)
