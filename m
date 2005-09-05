Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVIEEOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVIEEOv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 00:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVIEEOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 00:14:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25740
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932193AbVIEEOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 00:14:50 -0400
Date: Sun, 04 Sep 2005 21:15:05 -0700 (PDT)
Message-Id: <20050904.211505.00894889.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: davej@redhat.com, hyoshiok@miraclelinux.com, mm-commits@vger.kernel.org
Subject: Re: x86-cache-pollution-aware-__copy_from_user_ll.patch added to
 -mm tree
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050904144218.7fe25102.akpm@osdl.org>
References: <200509042017.j84KHekQ032373@shell0.pdx.osdl.net>
	<20050904202333.GA4715@redhat.com>
	<20050904144218.7fe25102.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 4 Sep 2005 14:42:18 -0700

> It seems a strange thing to check though.   Do we really need it?

Other platforms already do, it's a very good sanity check.
