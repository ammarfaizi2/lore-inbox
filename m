Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265767AbUEZStw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265767AbUEZStw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUEZStv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:49:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24045 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265767AbUEZStu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:49:50 -0400
Date: Wed, 26 May 2004 11:49:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: benh@kernel.crashing.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32 implementation of ptep_set_access_flags
Message-Id: <20040526114904.7ebce835.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0405260756590.1929@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	<20040525153501.GA19465@foobazco.org>
	<Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
	<20040525102547.35207879.davem@redhat.com>
	<Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>
	<20040525105442.2ebdc355.davem@redhat.com>
	<Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
	<1085521251.24948.127.camel@gaston>
	<Pine.LNX.4.58.0405251452590.9951@ppc970.osdl.org>
	<Pine.LNX.4.58.0405251455320.9951@ppc970.osdl.org>
	<1085522860.15315.133.camel@gaston>
	<Pine.LNX.4.58.0405251514200.9951@ppc970.osdl.org>
	<1085530867.14969.143.camel@gaston>
	<Pine.LNX.4.58.0405251749500.9951@ppc970.osdl.org>
	<1085541906.14969.412.camel@gaston>
	<Pine.LNX.4.58.0405252031270.15534@ppc970.osdl.org>
	<1085546780.5584.19.camel@gaston>
	<Pine.LNX.4.58.0405252151100.15534@ppc970.osdl.org>
	<1085551152.6320.38.camel@gaston>
	<1085554527.7835.59.camel@gaston>
	<1085555491.7835.61.camel@gaston>
	<Pine.LNX.4.58.0405260756590.1929@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 08:22:35 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> The "new" rules (well, they aren't new, but now they are explicitly
> spelled out) for this thing are

Looks great to me.
