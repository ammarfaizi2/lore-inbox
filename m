Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTHSSrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbTHSSmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:42:38 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:8598 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261168AbTHSSeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:34:02 -0400
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: jes@wildopensource.com, zaitcev@redhat.com, khc@pm.waw.pl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030819095547.2bf549e3.davem@redhat.com>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	 <20030818111522.A12835@devserv.devel.redhat.com>
	 <m33cfyt3x6.fsf@trained-monkey.org>
	 <1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	 <20030819095547.2bf549e3.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061317998.30567.44.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 19 Aug 2003 19:33:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-19 at 17:55, David S. Miller wrote:
> (d) Makes implementations have to verify the mask is usable
> on every mapping attempt.

Or once per type with a bit of thought about it. I deal with
hardware that has 2 limits on its consistent allocs and a
different one with its streaming I/O buffers. It doesn't seem
too atypical either

