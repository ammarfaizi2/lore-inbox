Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWGYElB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWGYElB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWGYElB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:41:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21641 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932441AbWGYElA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:41:00 -0400
Date: Mon, 24 Jul 2006 21:40:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: greg@kroah.com, dsd@gentoo.org, jeff@garzik.org, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-Id: <20060724214046.1c1b646e.akpm@osdl.org>
In-Reply-To: <20060717003418.GA27166@tuatara.stupidest.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	<44B77B1A.6060502@garzik.org>
	<44B78294.1070308@gentoo.org>
	<44B78538.6030909@garzik.org>
	<20060714074305.1248b98e.akpm@osdl.org>
	<44BA48A0.2060008@gentoo.org>
	<20060716183126.GB4483@kroah.com>
	<20060717003418.GA27166@tuatara.stupidest.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2006 17:34:18 -0700
Chris Wedgwood <cw@f00f.org> wrote:

> On Sun, Jul 16, 2006 at 11:31:26AM -0700, Greg KH wrote:
> 
> > Looks ok to me, but I'll defer to Jeff for this one.
> 
> Could we make sure this doesn't cause any regressions with KT800
> chipsets (I think that's it, the VIA thing used on some Athlon64
> mainboards).
> 
> IIRC some require the quirk and some seem to work without it, the
> later class can use the IOAPIC and if we do this might be be breaking
> that?

Do you recall which of the several reporters had such a system?
