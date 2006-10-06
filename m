Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbWJFUhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWJFUhe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWJFUhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:37:34 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:44750 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932605AbWJFUhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:37:33 -0400
Date: Fri, 6 Oct 2006 22:33:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Howells <dhowells@redhat.com>
cc: torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4]
In-Reply-To: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr>
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+ *   the massive ternary operator construction
>+	(sizeof(n) <= 4) ?			\
>+	__ilog2_u32(n) :			\
>+	__ilog2_u64(n)				\

Should not this be: sizeof(n) <= sizeof(u32)


	-`J'
-- 
