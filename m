Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbTGOMld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267590AbTGOMlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:41:32 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:1017 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S267638AbTGOM1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:27:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Jeff Garzik <jgarzik@pobox.com>, David griego <dagriego@hotmail.com>
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Date: Tue, 15 Jul 2003 07:42:01 -0500
X-Mailer: KMail [version 1.2]
Cc: alan@storlinksemi.com, linux-kernel@vger.kernel.org
References: <Sea2-F50x3G5aYY61LE00011019@hotmail.com> <3F1303FA.8080706@pobox.com>
In-Reply-To: <3F1303FA.8080706@pobox.com>
MIME-Version: 1.0
Message-Id: <03071507420100.27793@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 July 2003 14:26, Jeff Garzik wrote:
> David griego wrote:
> > How does one measure the reliability and security of current software
> > TCP/IP stacks?  Some standard set of test would have to be identified
> > and the TOEs would need to be tested against this to ensure that they
> > meet some minimum standard.  I would suggest offloading the minimum
> > amount from the OS so that most of the control could be maintaind by the
> > OS stack.  This also would make failover/routing changes between TOE
> > -TOE, and TOE-NIC easier.
>
> Anything beyond basic host-only TOE adds massive complexity for very
> little gain:  interfacing netfilter and routing code with a black box we
> _hope_ will act properly sounds like suicide.
>
>  >  Current offloads such as checksum and
> >
> > segmentation will not be enough for 10GbE processing, so it would have
> > to be something more than we have today.
>
> All this is vague handwaving without supporting evidence.  So far we get
> stuff like Internet2 speed records _without_ TOE.  And Linux currently
> supports 10gige...  and hosts are just going to keep getting faster and
> faster.
>
> 	Jeff

Not to mention the problems IPSec would have with such a device.
