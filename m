Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTHSTCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbTHSSmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:42:24 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:61190 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S272961AbTHSSb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:31:59 -0400
Message-ID: <089d01c36680$09c04b30$c801a8c0@llewella>
From: "Bas Bloemsaat" <bloemsaa@xs4all.nl>
To: "David S. Miller" <davem@redhat.com>,
       "Richard Underwood" <richard@aspectgroup.co.uk>
Cc: <skraw@ithnet.com>, <willy@w.ods.org>, <alan@lxorguk.ukuu.org.uk>,
       <carlosev@newipnet.com>, <lamont@scriptkiddie.org>, <davidsen@tmr.com>,
       <marcelo@conectiva.com.br>, <netdev@oss.sgi.com>,
       <linux-net@vger.kernel.org>, <layes@loran.com>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>
References: <353568DCBAE06148B70767C1B1A93E625EAB5E@post.pc.aspectgroup.co.uk> <20030819111358.35ef1059.davem@redhat.com>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Tue, 19 Aug 2003 20:30:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Ok, then how would you propose to be able to send
> > > packets out an interface _before_ we have addresses
> > > assigned to it?
> > >
> > IP packets you mean? You don't? ;) It would depend on why you're
> > doing it naturally. Mostly, I'd have thought that if a host doesn't have
an
> > IP number it doesn't get to use ARP.
>
> Of course it gets to use ARP, nothing prevents this.
Huh? RFC 826 states that the requesting arp packet sends the protocol
address of itself. So no address is no arp.

Allowing it to is a violation of that rfc

Regards,
Bas


