Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWE2Vde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWE2Vde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWE2Vdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:33:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51926 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751420AbWE2VdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:33:20 -0400
Subject: Re: /sys/class/net/eth?/carrier and uevents
From: Arjan van de Ven <arjan@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: =?ISO-8859-1?Q?Jo=E3o?= Luis Meloni Assirati 
	<assirati@nonada.if.usp.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490605291429h32f67b53k757d6e4a0cec7675@mail.gmail.com>
References: <200605291807.42725.assirati@nonada.if.usp.br>
	 <9a8748490605291429h32f67b53k757d6e4a0cec7675@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 29 May 2006 23:33:15 +0200
Message-Id: <1148938395.3291.104.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I added the 'carrier' attribute initially but never considered udev at
> the time. But I can certainly see how it could be useful.
> I'll take a look at adding a hotplug event when I get some spare time
> (probably some time next week) - or perhaps someone else will beat me
> to it :)

there is a netlink event already though... is this really worth the
duplication?

