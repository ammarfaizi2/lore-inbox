Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267881AbUHSCqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267881AbUHSCqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267966AbUHSCqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:46:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60131 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267881AbUHSCqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:46:22 -0400
Date: Wed, 18 Aug 2004 19:43:13 -0700
From: "David S. Miller" <davem@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-Id: <20040818194313.385f4d2f.davem@redhat.com>
In-Reply-To: <20040819023848.GY11200@holomorphy.com>
References: <20040818133348.7e319e0e.pj@sgi.com>
	<20040818205338.GF11200@holomorphy.com>
	<20040818135638.4326ca02.davem@redhat.com>
	<20040818210503.GG11200@holomorphy.com>
	<20040818143029.23db8740.davem@redhat.com>
	<20040818214026.GL11200@holomorphy.com>
	<20040818220001.GN11200@holomorphy.com>
	<20040818225915.GQ11200@holomorphy.com>
	<20040818161658.49aa8de3.davem@redhat.com>
	<20040818233324.GT11200@holomorphy.com>
	<20040819023848.GY11200@holomorphy.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 19:38:48 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> Oddly, the sparc64 case seems to be the most difficult one for the
> io_remap_page_range() sweep...

Oh yeah, that's due to the large TLB mapping support
isn't it?
