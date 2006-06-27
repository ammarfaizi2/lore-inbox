Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWF0MSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWF0MSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWF0MSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:18:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56705 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751318AbWF0MSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:18:20 -0400
Subject: Re: make PROT_WRITE imply PROT_READ
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ulrich Drepper <drepper@gmail.com>, Jason Baron <jbaron@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060627095632.GA22666@elf.ucw.cz>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
	 <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
	 <1151072280.3204.17.camel@laptopd505.fenrus.org>
	 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
	 <20060627095632.GA22666@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 14:18:12 +0200
Message-Id: <1151410692.5217.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, some hardware can probably support write-only, and such support
> can be useful for "weird" applications, such as just-in-time
> compilers, etc.

it also makes sense for PCI MMIO mappings..

