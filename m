Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUHZBFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUHZBFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 21:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUHZBE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 21:04:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266613AbUHZA61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:58:27 -0400
Date: Wed, 25 Aug 2004 17:58:05 -0700
From: "David S. Miller" <davem@redhat.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: linux-kernel@vger.kernel.org, Brian.Somers@Sun.COM
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040825175805.6807014c.davem@redhat.com>
In-Reply-To: <412CF0E9.2010903@sun.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com>
	<412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com>
	<412CF0E9.2010903@sun.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 16:04:57 -0400
Mike Waychison <Michael.Waychison@Sun.COM> wrote:

> If I understand it correctly, the problem we were seeing is that the
> chip was getting framing errors in high-traffic scenarios.  Setting it
> to use hardware autoneg made these errors disappear.  It's possible we
> need some other work-around.. :\

So what rev 5704 chips were in Sun's Opteron boxes where you
saw the problem?  A0/A1 chips?
