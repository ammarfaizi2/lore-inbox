Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267682AbUHFEUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267682AbUHFEUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUHFEUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:20:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36581 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267682AbUHFEUM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:20:12 -0400
Date: Thu, 5 Aug 2004 21:19:49 -0700
From: "David S. Miller" <davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: ak@muc.de, jgarzik@pobox.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-Id: <20040805211949.11fa33b7.davem@redhat.com>
In-Reply-To: <20040805.204637.107575718.yoshfuji@linux-ipv6.org>
References: <20040804232116.GA30152@muc.de>
	<20040804.165113.06226042.yoshfuji@linux-ipv6.org>
	<20040805114917.GC31944@muc.de>
	<20040805.204637.107575718.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2004 20:46:37 -0700 (PDT)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> I'd suggest changing XFRM_MSG_xxx things to 64bit-aware structures,
> whose layouts do not change between 64bit mode and 32bit mode.
> Of course, they will come with backward compatibility stuff.
> If you don't mind this, I'd like to take care of this.

I think other tasks have much higher priority, especially
when a workaround exists for this problem, namely building
the native 64-bit version of the tool.
