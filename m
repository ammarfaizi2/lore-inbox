Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266166AbUGTTjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUGTTjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUGTTjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:39:06 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:58870 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266166AbUGTTin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:38:43 -0400
Date: Tue, 20 Jul 2004 15:41:54 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Mark Watts <m.watts@eris.qinetiq.com>, linux-kernel@vger.kernel.org
Subject: RE: Kernel oops while shutting down (2.6.8rc1)
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD5606@pdsmsx403>
Message-ID: <Pine.LNX.4.58.0407201538410.7535@montezuma.fsmlabs.com>
References: <3ACA40606221794F80A5670F0AF15F8403BD5606@pdsmsx403>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2004, Zhu, Yi wrote:

> > $ /sbin/lsmod
> > Module                  Size  Used by
> ...
> > processor              17032  1 thermal
>
> This is the root cause. See http://bugme.osdl.org/show_bug.cgi?id=1716,
> there is also a fix patch available.

Thanks for pinpointing it, i've posted a simple patch in the hopes that
it's sufficient.

	Zwane

