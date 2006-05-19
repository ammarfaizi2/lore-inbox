Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWESOkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWESOkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 10:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWESOkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 10:40:13 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:48354 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932321AbWESOkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 10:40:11 -0400
Message-ID: <446DD8B6.4060102@myri.com>
Date: Fri, 19 May 2006 16:39:50 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] myri10ge - Driver core
References: <20060517220218.GA13411@myri.com> <20060517220608.GD13411@myri.com> <200605180108.32949.arnd@arndb.de>
In-Reply-To: <200605180108.32949.arnd@arndb.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> dev_err?
>   
[...]

> Could probably use dev_printk.
>   

When the interface name is known, we prefer having the message look like
"myri10ge: eth2: something" since it might be easier to read than
""myri10ge: 00005:000e: something". The administrator usually knows the
name of the network interface better than its bus ID.

Brice

