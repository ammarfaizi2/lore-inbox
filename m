Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbUB1Ok3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 09:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUB1Ok3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 09:40:29 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:20715 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261855AbUB1Ok2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 09:40:28 -0500
Subject: Re: Where does this load come from?
From: Christophe Saout <christophe@saout.de>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1077971267.10257.24.camel@paragon.slim>
References: <1077971267.10257.24.camel@paragon.slim>
Content-Type: text/plain
Message-Id: <1077979223.11348.2.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 15:40:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa, den 28.02.2004 schrieb Jurgen Kramer um 13:27:

> I am seeing some strange load figures on my P4 Celeron based system
> which I cannot explain. There always seem to be some load while there
> are no real apps running. Stopping all daemons doesn't seem to effect
> things at all.

I've posted something like this before. It seems the load calculator
takes the io_wait "cpu usage" (which isn't really a cpu usage, it just
categorizes processes waiting in io_schedule here instead of the idle
time) into account. While doing heavy disk I/O my webserver showed a
load of over 40 but the cpu was idle. I don't like this either.


