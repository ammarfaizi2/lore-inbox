Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUHQRsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUHQRsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 13:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUHQRsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 13:48:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29840 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266538AbUHQRsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 13:48:10 -0400
Date: Tue, 17 Aug 2004 10:45:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: dev_null@anet.ne.jp, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27
Message-Id: <20040817104527.54a15eed.davem@redhat.com>
In-Reply-To: <41221036.2020701@tuxdriver.com>
References: <20040817110002.32088.38168.Mailman@linux.us.dell.com>
	<200408172129.AJH50391.692B5188@anet.ne.jp>
	<41221036.2020701@tuxdriver.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004 10:03:34 -0400
"John W. Linville" <linville@tuxdriver.com> wrote:

> Tetsuo Handa wrote:
> 
> > I compiled as a UP kernel but it wasn't the cause.
> > Also, I patched the above fix on 2.4.27-rc4 and
> > compiled as a UP kernel, but didn't work.
> > 
> 
> Testsuo,
> 
> Please send the output of `lspci -vv`.  It might be helpful to know 
> exactly which device is involved.
> 
> David,
> 
> FWIW, I think I'm seeing the same problem with the BCM5751 built-in to 
> my HP xw4200...

This bug can only affect 5704 chips with fiber interfaces.
