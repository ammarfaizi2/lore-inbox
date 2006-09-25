Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWIYVqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWIYVqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWIYVqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:46:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4234 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751476AbWIYVqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:46:11 -0400
Date: Mon, 25 Sep 2006 14:45:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
 pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-Id: <20060925144558.878c5374.akpm@osdl.org>
In-Reply-To: <1159220043.12814.30.camel@nigel.suspend2.net>
References: <20060925071338.GD9869@suse.de>
	<1159220043.12814.30.camel@nigel.suspend2.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 07:34:03 +1000
Nigel Cunningham <ncunningham@linuxmail.org> wrote:

> </rant>

metoo!  I'd suggest that it'd be better to be expending the grey cells on
making the present suspend stuff nice and solid, stable and fast.

I mean, right now a suspend-to-disk spends more time futzing around doing
mysterious-but-probably-pointless stuff than it does writing memory to
disk.  I've no idea what it's doing with all that time, but I'll wager it's
not very useful to anyone ;)

