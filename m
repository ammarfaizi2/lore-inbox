Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbUJ1SIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbUJ1SIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbUJ1SIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:08:15 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:22668
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263018AbUJ1SE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:04:56 -0400
Date: Thu, 28 Oct 2004 10:56:37 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: sparc ffb drm driver...
Message-Id: <20041028105637.06794bbc.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0410281222450.15369@skynet>
References: <Pine.LNX.4.58.0410281222450.15369@skynet>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004 12:38:08 +0100 (IST)
Dave Airlie <airlied@linux.ie> wrote:

> Unless we can up with some plan for the future (user and kernel space),
> this driver will be marked broken in my next merge and may in fact end
> up broken as a side effect of the changes for the core/personality split..

I agree, let's toss it for now.  It's there in the history and
it can be resurrected if anyone wants to.

In my most recent patches to the sunffb x11 driver I had to disable
drm entirely after adding Render support.
