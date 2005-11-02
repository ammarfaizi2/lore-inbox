Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVKBB5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVKBB5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 20:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVKBB5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 20:57:47 -0500
Received: from quechua.inka.de ([193.197.184.2]:61661 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932167AbVKBB5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 20:57:47 -0500
From: root <root@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: best way to handle LEDs
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20051101234459.GA443@elf.ucw.cz>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EX7sn-0006It-00@calista.inka.de>
Date: Wed, 02 Nov 2005 02:57:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20051101234459.GA443@elf.ucw.cz> you wrote:
> +static ssize_t leds_store_frequency(struct class_device *dev, const char *buf, size_t size)

how about using a on and a off timer, so you can set up 50,50 or 10,90 or
stuff like that to make different pulse.

I know the TI avalanch  platform has a quite complicated led driver, which I
think is much overworked since it allows led settings based on logical
states. This should all be in userspace. 

Gruss
Bernd
