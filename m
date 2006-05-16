Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWEPWiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWEPWiU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWEPWiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:38:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6827 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932228AbWEPWiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:38:19 -0400
Subject: Re: PATCH: Fix broken PIO with libata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b0ffc1f0605161019j7149f72bv309db19eb9d12dd8@mail.gmail.com>
References: <1147790393.2151.62.camel@localhost.localdomain>
	 <3b0ffc1f0605160833k5f6355c5n3f2a9ab1b211a95@mail.gmail.com>
	 <1147794791.2151.71.camel@localhost.localdomain>
	 <3b0ffc1f0605161019j7149f72bv309db19eb9d12dd8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 23:51:15 +0100
Message-Id: <1147819875.6169.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-16 at 13:19 -0400, Kevin Radloff wrote:
> Hrm, as I recall that only started happening with ide-cs sometime in
> the single digits of 2.6.x.. And note that it's only maxing out at
> about 1.5MB/s. Should that saturate my laptop's 1.1GHz Pentium M
> processor?

Yes. It is possible that adding 32bit I/O support will boost this a
little but not much, and it may not work on all cards. The PCMCIA bus is
ISA speed, 1.5MB/sec is pretty much flat out


Alan

