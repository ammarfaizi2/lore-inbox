Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWA0T6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWA0T6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWA0T6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:58:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30652 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751325AbWA0T6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:58:24 -0500
Date: Fri, 27 Jan 2006 11:57:50 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: greg@kroah.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: 2.6.16-rc1-mm3
Message-Id: <20060127115750.25c6466b.zaitcev@redhat.com>
In-Reply-To: <43DA7722.6060107@reub.net>
References: <20060124232406.50abccd1.akpm@osdl.org>
	<43D7567E.60003@reub.net>
	<20060126053941.GA13361@kroah.com>
	<43DA161C.1070404@reub.net>
	<20060127172720.GB13320@kroah.com>
	<20060127094947.7439935d.zaitcev@redhat.com>
	<43DA7722.6060107@reub.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2006 08:40:18 +1300, Reuben Farrelly <reuben-lkml@reub.net> wrote:

> direction to fixing this, perhaps something more like "0000:00:1d.7 EHCI: BIOS 
> handoff failed (BIOS bug?  Try disabling legacy USB support in BIOS if it is 
> enabled)"

I thought about this. However it seems that a blanket implication of BIOS
vendors would not be ethical. Certainly our code is not infallible, and
the handoff continues to improve.

I expect BIOS developers to stop providing legacy support eventually.
It's like the ISA bus, which seemed impossible to get rid of.

-- Pete
