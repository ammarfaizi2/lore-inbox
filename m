Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264413AbUD0Xbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264413AbUD0Xbn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbUD0Xbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:31:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20946 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264503AbUD0Xbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:31:35 -0400
Date: Tue, 27 Apr 2004 16:30:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eliminate large inline's in skbuff
Message-Id: <20040427163031.4633f554.davem@redhat.com>
In-Reply-To: <20040427142136.35b521d5@dell_ss3.pdx.osdl.net>
References: <200404212226.28350.vda@port.imtp.ilyichevsk.odessa.ua>
	<Xine.LNX.4.44.0404212046490.20483-100000@thoron.boston.redhat.com>
	<20040427142136.35b521d5@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004 14:21:36 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> This takes the suggestion and makes all the locked skb_ stuff, not inline.
> It showed a 3% performance improvement when doing single TCP stream over 1G
> Ethernet between SMP machines. Test was average of 10 iterations of
> iperf for 30 seconds and SUT was 4 way Xeon.  Http performance difference
> was not noticeable (less than the std. deviation of the test runs).

Ok, let's give this a spin.

Applied, thanks.
