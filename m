Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936197AbWLEFyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936197AbWLEFyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758979AbWLEFyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:54:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49316 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758890AbWLEFyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:54:40 -0500
Date: Mon, 4 Dec 2006 21:54:04 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Kristian =?UTF-8?B?SMO4Z3NiZXJnIg==?= <krh@redhat.com>"@redhat.com
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH 2/3] Import fw-ohci driver.
Message-Id: <20061204215404.eacb95be.zaitcev@redhat.com>
In-Reply-To: <20061205052245.7213.39098.stgit@dinky.boston.redhat.com>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	<20061205052245.7213.39098.stgit@dinky.boston.redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2006 00:22:45 -0500, "Kristian Høgsberg" <krh@redhat.com> wrote:

Your wonderful crossed-o might be ok here (or it would've been if only
your mailer worked -- notice that the name is right in the "On" tag
line above):

> Signed-off-by: Kristian HÃ¸gsberg <krh@redhat.com>
> ---

But it's very much NOT OK here:

> + * fw-ohci.c - Driver for OHCI 1394 boards
> + * Copyright (C) 2003 Kristian HÃ¸gsberg <krh@bitplanet.net>

And you know why? Because the C code in kernel has no character set.

Even if the holy penguin declares "we use UTF-8 now", it's still not ok,
because people routinely send patches in e-mail.

So, please don't do that. I do not put "Copyright (c) 2006 Петр Зайцев"
in my patches out of courtesy to you. You might not even have fonts
for that. Now I expect the same from you.

-- Pete
