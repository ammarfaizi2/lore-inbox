Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270693AbTGNQ4P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270690AbTGNQ4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:56:09 -0400
Received: from dub.inr.ac.ru ([193.233.7.105]:56016 "HELO dub.inr.ac.ru")
	by vger.kernel.org with SMTP id S270598AbTGNQzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:55:01 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200307141709.VAA05176@dub.inr.ac.ru>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
To: davem@redhat.com (David S. Miller)
Date: Mon, 14 Jul 2003 21:09:12 +0400 (MSD)
Cc: davidel@xmailserver.org, e0206@foo21.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030712222457.3d132897.davem@redhat.com> from "David S. Miller" at Jul 12, 2003 10:24:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Alexey, they seem to want to add some kind of POLLRDHUP thing,
> comments wrt. TCP and elsewhere in the networking?  See below...

I see. It is highly reasonable. Unlike SVR4 POLLHUP. :-)

Well, "elsewhere" is mostly af_unix, half-duplex close makes sense only
for tcp and af_unix.

Alexey
