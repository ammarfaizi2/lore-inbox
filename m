Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVJBAeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVJBAeR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 20:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVJBAeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 20:34:17 -0400
Received: from smtp.terra.es ([213.4.129.129]:1924 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S1750927AbVJBAeR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 20:34:17 -0400
Date: Sun, 2 Oct 2005 02:34:05 +0200
From: grundig@teleline.es
To: Arjan van de Ven <arjan@infradead.org>
Cc: lokumsspand@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Message-Id: <20051002023405.3f63945e.grundig@teleline.es>
In-Reply-To: <1128202754.8153.0.camel@laptopd505.fenrus.org>
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
	<1128202754.8153.0.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 01 Oct 2005 23:39:14 +0200,
Arjan van de Ven <arjan@infradead.org> escribió:


> there is a LOT of state though.. the moment you add networking in the
> picture the amount of state just isn't funny anymore. Your X example is
> a good one as well...

If X allowed to disconnect an app from the server and re-connect it again
(and it seems there's people in X.org looking into things like this since
its neccesary for people using X's networkin through wireless connections)
it'd be easier to support it.

Some operative systems already have something like this and call
it "process checkpointing": "Checkpointing allows you to freeze a copy of an
application, and then at a later time, it can be restored."
http://kerneltrap.org/node/1042

Desktops users would love it: Instead of "exiting" your desktop session,
just dump all your running apps to disk, restore them the next time
you start your desktop, just like you left. This is already doable with some
support from apps, but doesn't seem to be implemented in the real world :/
