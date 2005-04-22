Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVDVRxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVDVRxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 13:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVDVRxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 13:53:40 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:23265
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262090AbVDVRxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 13:53:37 -0400
Date: Fri, 22 Apr 2005 10:46:25 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TG3]: Add msi test
Message-Id: <20050422104625.57f80a6a.davem@davemloft.net>
In-Reply-To: <1114156452.6685.17.camel@laptopd505.fenrus.org>
References: <200504220501.j3M51lkG012997@hera.kernel.org>
	<1114156452.6685.17.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2005 09:54:12 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> While the technicals of this change are ok, this still concerns me. Are
> all MSI drivers now supposed to check if the bios/mobo actually support
> MSI like this? That sounds sort of wrong! 

It's a temporary situation I believe.  Later on when our blacklist
is more comprehensive we can remove this kind of test code.

The test does spit a message out, so we will likely get a report
and therefore be able to update our MSI blacklists as appropriate.
