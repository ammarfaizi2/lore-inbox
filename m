Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270718AbTGNREM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270723AbTGNRDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:03:11 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:33726 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270718AbTGNRCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:02:22 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jul 2003 10:09:47 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: kuznet@ms2.inr.ac.ru
cc: "David S. Miller" <davem@redhat.com>, e0206@foo21.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <200307141709.VAA05176@dub.inr.ac.ru>
Message-ID: <Pine.LNX.4.55.0307141007340.4828@bigblue.dev.mcafeelabs.com>
References: <200307141709.VAA05176@dub.inr.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > Alexey, they seem to want to add some kind of POLLRDHUP thing,
> > comments wrt. TCP and elsewhere in the networking?  See below...
>
> I see. It is highly reasonable. Unlike SVR4 POLLHUP. :-)
>
> Well, "elsewhere" is mostly af_unix, half-duplex close makes sense only
> for tcp and af_unix.

If you agree guys, we can prepare a patch that does the handling in all
places where it has a mean. So that you can look at it.



- Davide

