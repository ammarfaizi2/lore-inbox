Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbTGAF4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbTGAF4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:56:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58067 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265985AbTGAF4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:56:08 -0400
Date: Mon, 30 Jun 2003 23:03:29 -0700 (PDT)
Message-Id: <20030630.230329.35692088.davem@redhat.com>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI domain stuff
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3F0124FC.1010001@zytor.com>
References: <bdr7a6$4eu$1@cesium.transmeta.com>
	<1057039376.32118.3.camel@rth.ninka.net>
	<3F0124FC.1010001@zytor.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "H. Peter Anvin" <hpa@zytor.com>
   Date: Mon, 30 Jun 2003 23:06:52 -0700

   Perhaps a libdirectio would be useful?
   
The details are very PCI specific, so what you'd be working
on initially is a PCI centric library.

Over time things can be abstracted, but the initial PCI specific
one would be good enough for xfree86 to link to and make use
of which is a huge step in the right direction.
