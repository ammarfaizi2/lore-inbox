Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266067AbUF2VTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266067AbUF2VTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUF2VTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:19:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55983 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266067AbUF2VTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:19:35 -0400
Date: Tue, 29 Jun 2004 14:19:15 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistency between SIOCGIFCONF and SIOCGIFNAME
Message-Id: <20040629141915.0268b741.davem@redhat.com>
In-Reply-To: <40E1BE7D.7070806@redhat.com>
References: <40E0EAC1.50101@redhat.com>
	<20040629012604.20c3ad8b.davem@redhat.com>
	<40E1BE7D.7070806@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ulrich, is there a major reason why you can't use RTNETLINK for
your implementation?  It behaves as you desire and gives you
all of the link information you are after, in place of SIOCGIFCONF.

I've done some more thinking and I really don't want to put this
SIOCGIFCONF hack into the tree.
