Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWE2XCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWE2XCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWE2XCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:02:12 -0400
Received: from nonada.if.usp.br ([143.107.131.169]:37522 "EHLO
	nonada.if.usp.br") by vger.kernel.org with ESMTP id S932081AbWE2XCL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:02:11 -0400
From: =?iso-8859-1?q?Jo=E3o_Luis_Meloni_Assirati?= 
	<assirati@nonada.if.usp.br>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: /sys/class/net/eth?/carrier and uevents
Date: Mon, 29 May 2006 20:02:21 -0300
User-Agent: KMail/1.7.2
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <200605291807.42725.assirati@nonada.if.usp.br> <9a8748490605291429h32f67b53k757d6e4a0cec7675@mail.gmail.com> <1148938395.3291.104.camel@laptopd505.fenrus.org>
In-Reply-To: <1148938395.3291.104.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605292002.21576.assirati@nonada.if.usp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg 29 Mai 2006 18:33, Arjan van de Ven escreveu:
> > I added the 'carrier' attribute initially but never considered udev at
> > the time. But I can certainly see how it could be useful.
> > I'll take a look at adding a hotplug event when I get some spare time
> > (probably some time next week) - or perhaps someone else will beat me
> > to it :)
>
> there is a netlink event already though... is this really worth the
> duplication?

IMHO the ability to substitute a daemon with a simple udev rule, together with 
the benefit of notification by d-bus to the user interface (say KDE) makes it 
worth.

Regards,
João.
