Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264315AbUD0TwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbUD0TwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbUD0TwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:52:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58832 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264315AbUD0Tvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:51:41 -0400
Date: Tue, 27 Apr 2004 12:49:06 -0700
From: "David S. Miller" <davem@redhat.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: jmorris@redhat.com, Matt_Domsch@dell.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/libcrc32c, revised 040427
Message-Id: <20040427124906.6bb753eb.davem@redhat.com>
In-Reply-To: <yqujoepd9pb8.fsf_-_@chaapala-lnx2.cisco.com>
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com>
	<yqujr7vai6k4.fsf@chaapala-lnx2.cisco.com>
	<200403302043.22938.bzolnier@elka.pw.edu.pl>
	<yqujwu52ywsy.fsf@chaapala-lnx2.cisco.com>
	<20040330192350.GB5149@lists.us.dell.com>
	<yquj1xn87mpy.fsf_-_@chaapala-lnx2.cisco.com>
	<yqujpta3y7ia.fsf_-_@chaapala-lnx2.cisco.com>
	<20040423164226.3d6fa2c3.davem@redhat.com>
	<yqujoepd9pb8.fsf_-_@chaapala-lnx2.cisco.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004 14:46:35 -0500
Clay Haapala <chaapala@cisco.com> wrote:

> Attribute(pure) was used, so I changed the patch to use the define in
> compiler.h, as you suggest.  I will also change crc32.c, and submit in
> a second patch.  This is a patch against 2.6.5 sources.  I did not
> change the crypto patch, as this construct was not used there.

Please include linux/compiler.h if you're going to use it :-)

Once you fix that, send it again and resend the crypto part to
me as well and I'll apply everything for you.

Thanks a lot for following up on this.
