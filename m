Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUEEDV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUEEDV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 23:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUEEDVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 23:21:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54972 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261597AbUEEDVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 23:21:54 -0400
Date: Tue, 4 May 2004 20:18:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: m.c.p@kernel.linux-systeme.com, linux-kernel@vger.kernel.org,
       bunk@fs.tum.de, marcelo.tosatti@cyclades.com
Subject: Re: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
Message-Id: <20040504201832.1c8d07a3.davem@redhat.com>
In-Reply-To: <20040504205659.GA17583@havoc.gtf.org>
References: <20040503230911.GE7068@logos.cnet>
	<20040504204633.GB8643@fs.tum.de>
	<200405042253.11133@WOLK>
	<20040504205659.GA17583@havoc.gtf.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004 16:56:59 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> > yep. Either we backport WARN_ON ;) or simply do the attached.
> 
> I would rather add the simple patch to 2.4.x core, since tg3 isn't the
> only driver that continues to be heavily used in 2.4, and thus will
> continue to be actively maintained for a while...

I agree, anyone cooking up a patch for this?
