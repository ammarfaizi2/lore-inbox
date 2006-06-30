Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWF3MDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWF3MDG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWF3MDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:03:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48530 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932158AbWF3MDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:03:04 -0400
Subject: Re: [linux-usb-devel] [PATCH] Airprime driver improvements to
	allow full speed EvDO transfers
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Organov <osv@javad.com>, Andrew Morton <akpm@osdl.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <1151669628.31392.14.camel@localhost.localdomain>
References: <1151646482.3285.410.camel@tahini.andynet.net>
	 <20060630001021.2b49d4bd.akpm@osdl.org>  <874py2apca.fsf@javad.com>
	 <1151669628.31392.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 14:02:50 +0200
Message-Id: <1151668970.11434.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > tty_insert_flip_string() returns number of bytes it has actually
> > inserted, but I don't believe one can do much if it returns less than
> > has been requested as it means that we are out of kernel memory.
> 
> Yes. I've been wondering if we should log the failure case somewhere,
> either as a tty-> object or printk.

printk gets... interesting if you use serial console ;)

both locking and buffer space wise

