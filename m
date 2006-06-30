Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWF3NSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWF3NSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWF3NSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:18:41 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50361 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932099AbWF3NSk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:18:40 -0400
Subject: Re: [linux-usb-devel] [PATCH] Airprime driver improvements to
	allow full speed EvDO transfers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Sergei Organov <osv@javad.com>, Andrew Morton <akpm@osdl.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <1151668970.11434.30.camel@laptopd505.fenrus.org>
References: <1151646482.3285.410.camel@tahini.andynet.net>
	 <20060630001021.2b49d4bd.akpm@osdl.org>  <874py2apca.fsf@javad.com>
	 <1151669628.31392.14.camel@localhost.localdomain>
	 <1151668970.11434.30.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 14:34:42 +0100
Message-Id: <1151674482.31392.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 14:02 +0200, ysgrifennodd Arjan van de Ven:
> > Yes. I've been wondering if we should log the failure case somewhere,
> > either as a tty-> object or printk.
> 
> printk gets... interesting if you use serial console ;)
> both locking and buffer space wise

Not particularly. This is on the receive path not the transmit path so
the locking considerations don't arise.

Alan

