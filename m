Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUDSBJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 21:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264234AbUDSBJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 21:09:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36557 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264231AbUDSBJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 21:09:56 -0400
Date: Sun, 18 Apr 2004 18:08:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andreas Jochens <aj@andaco.de>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] tg3 driver - make use of binary-only firmware optional
Message-Id: <20040418180811.0b2e2567.davem@redhat.com>
In-Reply-To: <20040418135534.GA6142@andaco.de>
References: <20040418135534.GA6142@andaco.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Apr 2004 15:55:34 +0200
Andreas Jochens <aj@andaco.de> wrote:

> The Debian distribution recently removed the tg3 Gigabit Ethernet driver
> from its 2.6 kernels because it contains binary-only firmware, 
> i.e. software without source code, which violates the 
> Debian Free Software Guildelines.

The debian folks can ship the tg3 driver in whatever form
they want to meet their political agenda.

However, that in no way means that Jeff and myself have to split
the firmware out of the driver either.  In fact, I do not want to
as I like keeping all of the network drivers I write in single
foo.c and foo.h files.
