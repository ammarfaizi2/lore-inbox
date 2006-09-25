Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWIYPP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWIYPP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 11:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWIYPP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 11:15:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39055 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750924AbWIYPP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 11:15:57 -0400
Subject: Re: [PATCH] restore libata build on frv
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060925142016.GI29920@ftp.linux.org.uk>
References: <1159186771.11049.63.camel@localhost.localdomain>
	 <1159183568.11049.51.camel@localhost.localdomain>
	 <20060924223925.GU29920@ftp.linux.org.uk>
	 <22314.1159181060@warthog.cambridge.redhat.com>
	 <5578.1159183668@warthog.cambridge.redhat.com>
	 <7276.1159186684@warthog.cambridge.redhat.com>
	 <20060925142016.GI29920@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 16:39:34 +0100
Message-Id: <1159198774.11049.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-25 am 15:20 +0100, ysgrifennodd Al Viro:
> Fine by me.  In that case we need to add
> 	depends on !FRV || BROKEN
> to drivers/ata/Kconfig and be done with that.  BTW, empty libata-portmap.h
> is equivalent to absent one - it still won't build.

>From every public piece of info I can find and from looking at the FRV
tree your changes are correct for the ports Al. I can't find any info on
how legacy IRQ routing is done on FRV systems but if it is not then set
the IRQ values to zero and maybe Dave will stop complaining.

Alan

