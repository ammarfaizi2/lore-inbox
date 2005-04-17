Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVDQGt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVDQGt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 02:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVDQGt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 02:49:58 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:10649
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261275AbVDQGt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 02:49:56 -0400
Date: Sat, 16 Apr 2005 23:44:39 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 & x86_64: Live Patching Funcion on 2.6.11.7
Message-Id: <20050416234439.5464e188.davem@davemloft.net>
In-Reply-To: <4261DC62.1070300@lab.ntt.co.jp>
References: <4261DC62.1070300@lab.ntt.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Takashi-san, have you ever investigated using kprobes to
implement this feature?  It seems a perfect fit, and would
allow support on several architectures other than just x86
and x86_64.

If kprobes does not meet your needs completely, it could
be trivially extended to do so.

I think implementing something like this from scratch is
not a good idea when we have much of the needed logic and
infrastructure already.
