Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269917AbUJGXMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269917AbUJGXMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269897AbUJGXLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:11:07 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:6313
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269913AbUJGXJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:09:04 -0400
Date: Thu, 7 Oct 2004 16:07:49 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: msipkema@sipkema-digital.com, cfriesen@nortelnetworks.com,
       hzhong@cisco.com, jst1@email.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041007160749.7c77b810.davem@davemloft.net>
In-Reply-To: <20041007230019.GA31684@mark.mielke.cc>
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>
	<41658C03.6000503@nortelnetworks.com>
	<015f01c4acbe$cf70dae0$161b14ac@boromir>
	<4165B9DD.7010603@nortelnetworks.com>
	<20041007150035.6e9f0e09.davem@davemloft.net>
	<000901c4acc4$26404450$161b14ac@boromir>
	<20041007152400.17e8f475.davem@davemloft.net>
	<20041007224242.GA31430@mark.mielke.cc>
	<20041007154722.2a09c4ab.davem@davemloft.net>
	<20041007230019.GA31684@mark.mielke.cc>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004 19:00:19 -0400
Mark Mielke <mark@mark.mielke.cc> wrote:

> Just say "it's a bug, but one we have chosen not to fix for practical
> reasons." That would have kept me out of this discussion. Saying the
> behaviour is correct and that POSIX is wrong - that raises hairs -
> both the question kind, and the concern kind.

If anything, I'm saying we're not POSIX compliant in this case
by choice.
