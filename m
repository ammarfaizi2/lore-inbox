Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbUCOVdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbUCOVdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:33:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262797AbUCOVdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:33:23 -0500
Date: Mon, 15 Mar 2004 13:33:14 -0800
From: "David S. Miller" <davem@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: cieciwa@alpha.zarz.agh.edu.pl, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [SPARC64][PPC] strange error ..
Message-Id: <20040315133314.08840781.davem@redhat.com>
In-Reply-To: <20040315204346.GB13167@smtp.west.cox.net>
References: <Pine.LNX.4.58L.0403151437360.16193@alpha.zarz.agh.edu.pl>
	<Pine.LNX.4.58L.0403151939460.17732@alpha.zarz.agh.edu.pl>
	<20040315190026.GG4342@smtp.west.cox.net>
	<20040315123953.3b6b863f.davem@redhat.com>
	<20040315204346.GB13167@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004 13:43:46 -0700
Tom Rini <trini@kernel.crashing.org> wrote:

> Erm, if I read include/asm-sparc{,64}/linkage.h right, 'asmlinkage' ends
> up being defined to ''.  So why not just remove 'asmlinkage' from the
> offending line in unistd.h ?

So that the declarations look consistent across platforms?
