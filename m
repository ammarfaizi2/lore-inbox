Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWAJRs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWAJRs7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWAJRs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:48:59 -0500
Received: from quechua.inka.de ([193.197.184.2]:51355 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932157AbWAJRs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:48:58 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: 2G memory split
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <43C3E9C2.1000309@rtr.ca>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EwNc8-00063F-00@calista.inka.de>
Date: Tue, 10 Jan 2006 18:48:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord <lkml@rtr.ca> wrote:
> So, the patch would now look like this:

can we please state something what the 3G_OPT is suppsoed to do? Is this "optimzed for 1GB Real RAM"? Should this be something like "2.5G" instead?

> +       config VMSPLIT_3G_OPT
> +               bool "3G/1G user/kernel split (for full 1G low memory)"

> +       default 0xC0000000
> +       default 0xB0000000 if VMSPLIT_3G_OPT
> +       default 0x78000000 if VMSPLIT_2G
> +       default 0x40000000 if VMSPLIT_1G

Grusss
Bernd
