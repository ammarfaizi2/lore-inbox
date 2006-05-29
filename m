Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWE2XRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWE2XRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWE2XRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:17:34 -0400
Received: from quechua.inka.de ([193.197.184.2]:12503 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932088AbWE2XRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:17:33 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <bda6d13a0605291347t71311c6g95ebf53aa2ac392f@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FkqzL-0001wQ-00@calista.eckenfels.net>
Date: Tue, 30 May 2006 01:17:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson <joshudson@gmail.com> wrote:
> If I ever need to know my outside-facing IP address, I connect a UDP
> socket to 1.2.3.4

Is your MUA doing that to construct MsgIDs? Your NUA? Your MTA? a local news
spool? For a robust installation of all of them you specify the name, but
some of those services better work out of the box, so the notion of a
primary FQDN is not that bad to have.

> and to a getsockname(). To get outside-hostname, I do a reverse-lookup on that.
> Since 1.0.0.0/8 will never be allocated, this is gauranteed to work
> when there is a way out.

Why should any of your IPs have a reverse resolveable name?

Gruss
Bernd
