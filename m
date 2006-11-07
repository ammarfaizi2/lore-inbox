Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753688AbWKGJms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbWKGJms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbWKGJms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:42:48 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56453 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1753688AbWKGJmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:42:47 -0500
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, akpm@osdl.org,
       Wilco Beekhuizen <wilcobeekhuizen@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061107012519.GC25719@redhat.com>
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
	 <1162817254.5460.4.camel@localhost.localdomain>
	 <1162847625.10086.36.camel@localhost.localdomain>
	 <20061107012519.GC25719@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Nov 2006 01:34:34 +0000
Message-Id: <1162863274.11073.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-11-06 am 20:25 -0500, ysgrifennodd Dave Jones:
> This got me wondering what PCI_VDEVICE was, so I went looking.
> It's a libata'ism it seems with the comment..
> 
> /* move to PCI layer? */
> 
> Which sounds like a good idea to me.  But until this is moved,
> does quirks.c actually compile with this patch? I don't see
> an include of linux/libata.h there.

Probably not - as I said "not tested"

