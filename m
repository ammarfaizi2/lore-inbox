Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUBQTHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUBQTHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:07:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41907 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266489AbUBQTGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:06:53 -0500
Date: Tue, 17 Feb 2004 11:05:41 -0800
From: "David S. Miller" <davem@redhat.com>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: matthias.andree@gmx.de, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com.br
Subject: Re: [PATCH] net/sctp/Config.in make oldconfig compatibility (bash)
Message-Id: <20040217110541.6d71ef18.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0402171035440.32361@localhost.localdomain>
References: <20040217122347.GA15213@merlin.emma.line.org>
	<Pine.LNX.4.58.0402171035440.32361@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004 10:48:55 -0800 (PST)
Sridhar Samudrala <sri@us.ibm.com> wrote:

> I thought SCTP changes were backed out just because of these 'make oldconfig'
> errors from the 2.4 tree.

I believe Marcelo is just going to clone a tree right before he took in the
SCTP stuff, in order to do the 2.4.25 release.  Then for 2.4.26-pre1 he'll
take the SCTP changes back in and we can add the fix.

> Anyway, i have submitted the attached patch that should fix this to davem.
> 'make oldconfig' and 'make menuconfig' worked fine after applying this patch.

I believe this space fix here is necessary as well as your crypto changes
Sridhar.
