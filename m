Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVB0Tb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVB0Tb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 14:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVB0Tb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 14:31:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48855 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261470AbVB0Tbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 14:31:47 -0500
Subject: Re: Bootsplash for 2.6.11-rc4
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michal Januszewski <spock@gentoo.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050227165420.GD1441@elf.ucw.cz>
References: <20050218165254.GA1359@elf.ucw.cz>
	 <20050219011433.GA5954@spock.one.pl> <20050219230326.GB13135@kroah.com>
	 <20050219232519.GC1372@elf.ucw.cz> <20050220132600.GA19700@spock.one.pl>
	 <20050227165420.GD1441@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 27 Feb 2005 20:31:39 +0100
Message-Id: <1109532700.15362.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, I like rhgb the best (because it is 100% userspace and I do not
> have to deal with it :-), but it seems like bootsplash should be
> deprecated in favor of fbsplash.

well.. how much does it really need in kernel space? I mean, with all
drivers as modules, and the "quiet" option, initramfs runs *really*
fast. And that can just bang a bitmap to the framebuffer as first
thing... (rhgb does it a bit later but that's a design choice in a
feature vs early-boot tradeoff).



