Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbTIDHcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264820AbTIDHal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:30:41 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:53190 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264784AbTIDHa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:30:28 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <3F5679E1.8090604@pobox.com>
References: <20030902231812.03fae13f.akpm@osdl.org>
	 <20030903161200.GC23729@fs.tum.de>  <3F5617A9.4040603@pobox.com>
	 <1062607559.1785.50.camel@gaston>  <3F5679E1.8090604@pobox.com>
Message-Id: <1062660583.1780.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 09:29:44 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH] Re: 2.6.0-test4-mm5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 01:31, Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
> > BTW. David: Any reason why you wouldn't let me change all occurences
> > of spin_{lock,unlock}_irq into the ...{save,restore} versions ?
> 
> 
> IMO... even though you do lose a tiny bit of performance, I definitely
> prefer the save/restore versions.

I'm not even sure you actually lose perfs... at least on ppc ;)

Ben.


