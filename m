Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUK1QXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUK1QXE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUK1QXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:23:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261505AbUK1QXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:23:00 -0500
Date: Sun, 28 Nov 2004 11:21:22 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       Tonnerre <tonnerre@thundrix.ch>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041128162122.GI10340@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <19865.1101395592@redhat.com> <41A8AF8F.8060005@osdl.org> <1101575782.21273.5347.camel@baythorne.infradead.org> <200411272353.54056.arnd@arndb.de> <1101626019.2638.2.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101626019.2638.2.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 08:13:39AM +0100, Arjan van de Ven wrote:
> > , spinlock.h
> 
> EHHHH????? Spinlocks in userland? You got to be kidding.

There is pthread_spin_{init,lock,unlock,trylock,destroy}
in libpthread.so.

	Jakub
