Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUF3UDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUF3UDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUF3UCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:02:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44205 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262079AbUF3UAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:00:08 -0400
Date: Wed, 30 Jun 2004 12:59:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistency between SIOCGIFCONF and SIOCGIFNAME
Message-Id: <20040630125927.20395598.davem@redhat.com>
In-Reply-To: <40E27103.8040304@redhat.com>
References: <40E0EAC1.50101@redhat.com>
	<20040629012604.20c3ad8b.davem@redhat.com>
	<40E1BE7D.7070806@redhat.com>
	<20040629141915.0268b741.davem@redhat.com>
	<40E24573.5030403@redhat.com>
	<20040629221341.52824096.davem@redhat.com>
	<40E27103.8040304@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 00:51:31 -0700
Ulrich Drepper <drepper@redhat.com> wrote:

> David S. Miller wrote:
> 
> > This is especially unnecessary since rtnetlink does exactly what you
> > want already, so we don't need to add a new interface nor change the
> > semantics of an old one.
> 
> I do have code using netlink in cvs now.  We'll see whether people complain.

Let me know, if you can't make it work I'm more than willing to
reconsider the SIOCGIFCONF change.
