Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWDOCYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWDOCYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 22:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWDOCYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 22:24:10 -0400
Received: from xenotime.net ([66.160.160.81]:59021 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750887AbWDOCYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 22:24:09 -0400
Date: Fri, 14 Apr 2006 19:26:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Libor Vanek" <libor.vanek@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Connector - how to start?
Message-Id: <20060414192634.697cd2e3.rdunlap@xenotime.net>
In-Reply-To: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com>
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2006 03:09:05 +0200 Libor Vanek wrote:

> Hi,
> I'd like to start writing some small module using connector to send
> messages to/from user-space. Unfortunately I'm absolutely not familiar
> with netlink/connector API usage and I couldn't find any usefull
> documentation (yes, I read Documentation/connector/ and tried Google).
> 
> So here's things which are not clear to me:
> - the Documentation/connector containts only kernel-space example -
> don't anybody have also "user-space client example"?
> - how do I ACK message sent to/from user-space?
> - in case of multiple clients listening how do I send message just to
> (random) one (simple load balancing) or to all of them? (broadcasting)
> - is there some "easy" way how to send longer messages then
> CONNECTOR_MAX_MSG_SIZE?

There was a connector userspace example posted to lkml on
2005-SEP-28:

Subject: [RFC] Process Events Connector (test program)
From:	Matthew Helsley <matthltc@us.ibm.com>


It seems like one of the Red Hat guys had some netlink documentation
and sample programs at people.redhat.com, but I can't find that
just now.

---
~Randy
