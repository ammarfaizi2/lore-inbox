Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268327AbUHYTJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268327AbUHYTJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHYTJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:09:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39602 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268310AbUHYTIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:08:47 -0400
Date: Wed, 25 Aug 2004 12:08:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: a5497108@anet.ne.jp, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040825120831.55a20c57.davem@redhat.com>
In-Reply-To: <412CD101.4050406@sun.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com>
	<412CD101.4050406@sun.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 13:48:49 -0400
Mike Waychison <Michael.Waychison@Sun.COM> wrote:

> Tetsuo posted his lscpi -vv output and he has an A2.  The hardware
> autoneg patch was written and tested against an A3.
> 
> Would it make sense to do (hand-edited):

Not really.  The autoneg code in the bcm5700 driver works on
all revisions of the 5704 chipset.

If I can't get this working soon, I'm disabling it for all boards.
The software based fibre autoneg should work just fine for
everyone.
