Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUFJACN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUFJACN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUFJACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:02:13 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:51716 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S266034AbUFJACM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:02:12 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <40C77C70.5070409@tmr.com> (Bill Davidsen's message of "Wed, 09
 Jun 2004 17:09:04 -0400")
References: <20040607212804.GA17012@k3.hellgate.ch>
	<20040607145723.41da5783.davem@redhat.com>
	<20040608210809.GA10542@k3.hellgate.ch> <40C77C70.5070409@tmr.com>
X-Hashcash: 0:040610:linux-kernel@vger.kernel.org:d4eecd74e8535e5c
Date: Wed, 09 Jun 2004 20:01:58 -0400
Message-ID: <m34qpke0w9.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bill" == Bill Davidsen <davidsen@tmr.com> writes:

Bill> It does sometimes matter, because even these days we sometimes
Bill> see a case where a brand name switch (like Cisco) and a brand
Bill> name card (Intel, 3COM) negotiate but just don't "work right"
Bill> later.

I just had this happen this week.  Both intel and broadcom cards
negatiated 100/full with the cisco switch, but failed to work
properly.  ethtool -s eth0 speed 100 duplex full autoneg off
improved performance from OTOO 15% of capacity to wire speed.

-JimC
