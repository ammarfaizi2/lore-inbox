Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVGJCO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVGJCO6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 22:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVGJCO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 22:14:58 -0400
Received: from quechua.inka.de ([193.197.184.2]:60567 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261815AbVGJCO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 22:14:57 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050710014559.GA15844@animx.eu.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DrRLL-00017G-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 10 Jul 2005 04:14:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050710014559.GA15844@animx.eu.org> you wrote:
> You misunderstood entirely what I said.

There is no portable/documented way to grow a file without having the file
system null its content. However why is that a problem, you dont create
those files very often. Besides it is better for the OS to be able to asume
that a page with zeros in it is equal to the page on fresh swap.

Gruss
Bernd
