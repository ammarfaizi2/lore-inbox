Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUHBCzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUHBCzY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 22:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUHBCzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 22:55:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266223AbUHBCzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 22:55:17 -0400
Date: Sun, 1 Aug 2004 19:54:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: arjanv@redhat.com
Cc: rwhite@casabyte.com, linux-kernel@vger.kernel.org
Subject: Re: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY
Message-Id: <20040801195411.0577b7f2.davem@redhat.com>
In-Reply-To: <1091261406.2819.1.camel@laptop.fenrus.com>
References: <20040729193637.36d018a5.davem@redhat.com>
	<!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAto7TSbyGCEOKEjP4Tiu9VgEAAAAA@casabyte.com>
	<20040730153700.2bb46976.davem@redhat.com>
	<1091261406.2819.1.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2004 10:10:06 +0200
Arjan van de Ven <arjanv@redhat.com> wrote:

> btw do we export MSG_MORE functionality to userspace ? That might be a
> solution as well...

Yes, we do.

