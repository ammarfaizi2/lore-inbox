Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932746AbVLKE7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbVLKE7o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 23:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbVLKE7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 23:59:44 -0500
Received: from quechua.inka.de ([193.197.184.2]:8413 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932746AbVLKE7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 23:59:43 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] ip / ifconfig redesign
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200512022253.19029.a1426z@gawab.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1ElJJF-0005mU-00@calista.inka.de>
Date: Sun, 11 Dec 2005 05:59:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200512022253.19029.a1426z@gawab.com> you wrote:
> The current ip / ifconfig configuration is arcane and inflexible.  The reason 
> being, that they are based on design principles inherited from the last 
> century.

Yes I agree, however note that some of the asumptions are backed up and
required by RFCs. For example the binding of addresses to interfaces. This
is especially strongly required in the IPV6 world with all the scoping and
renumbering RFCs.

The things you want to change need to be changed in kernel space, btw.

Gruss
Bernd
ifconfig maintainer

