Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUF3UzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUF3UzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUF3UzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:55:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262730AbUF3UzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:55:05 -0400
Date: Wed, 30 Jun 2004 13:54:19 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: jamie@shareable.org, wesolows@foobazco.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-Id: <20040630135419.25b843b8.davem@redhat.com>
In-Reply-To: <20040630082804.GS21264@devserv.devel.redhat.com>
References: <20040630030503.GA25149@mail.shareable.org>
	<20040630082804.GS21264@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 04:28:05 -0400
Jakub Jelinek <jakub@redhat.com> wrote:

> I believe R!X and X!R pages ought to be possible on sparc64 too, just use a
> different bit as "read" in the fast ITLB miss handler from the one fast DTLB
> miss uses.

That's correct.  But I have no plans to implement this
any time soon :-)
