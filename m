Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVAOT5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVAOT5s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 14:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVAOT5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 14:57:47 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:60124 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262307AbVAOT5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 14:57:46 -0500
Date: Sat, 15 Jan 2005 11:55:04 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       matthias@corelatus.se, linux-kernel@vger.kernel.org
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
Message-ID: <20050115195504.GA10754@taniwha.stupidest.org>
References: <16872.55357.771948.196757@antilipe.corelatus.se> <20050115013013.1b3af366.akpm@osdl.org> <20050115093657.GI3474@holomorphy.com> <1105783125.6300.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105783125.6300.32.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 10:58:45AM +0100, Arjan van de Ven wrote:

> I don't see a valid reason to restrict/reject input that is accepted
> now and dealt with reasonably because some standard says so (if you
> design a new api, following the standard is nice of course). I don't
> see "doesn't reject a condition that can reasonable be dealt with"
> as a good reason to go double ABI at all.

we could printk for now and if nobody reports this to lkml (as they
do/did with oldish tcpdump/libpcap a while ago) we could -EINVAL

