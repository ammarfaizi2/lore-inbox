Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUGFWtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUGFWtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUGFWtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:49:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264649AbUGFWss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:48:48 -0400
Date: Tue, 6 Jul 2004 15:45:55 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-Id: <20040706154555.79673f14.davem@redhat.com>
In-Reply-To: <20040706153417.237e454e.akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org>
	<20040706125438.GS21066@holomorphy.com>
	<20040706153417.237e454e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004 15:34:17 -0700
Andrew Morton <akpm@osdl.org> wrote:

> William Lee Irwin III <wli@holomorphy.com> wrote:
> >
> > Third, some naive check for undefined symbols failed to understand the
> > relocation types indicating that a given operand refers to some hard
> > register, which manifest as undefined symbols in ELF executables. A
> > patch to refine its criteria, which I used to build with, follows. rmk
> > and hpa have some other ideas on this undefined symbol issue I've not
> > quite had the opportunity to get a clear statement of yet.
> 
> I converted that to a non-fatal warning due to the same problem on sparc64.

Andrew, Russell posted to us in private email an objdump based
check that didn't trigger for the register declaration case.
