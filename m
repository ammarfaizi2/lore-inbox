Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFFQTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFFQTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 12:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVFFQTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 12:19:55 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:40334 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261207AbVFFQTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 12:19:52 -0400
Date: Mon, 6 Jun 2005 09:19:42 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Henk <Henk.Vergonet@gmail.com>
Cc: froese@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] new 7-segments char translation API
Message-Id: <20050606091942.2c31bb98.rdunlap@xenotime.net>
In-Reply-To: <20050606092608.GA16471@god.dyndns.org>
References: <20050531220738.GA21775@god.dyndns.org>
	<429DAB07.1050900@anagramm.de>
	<20050604204403.GA10417@god.dyndns.org>
	<20050605005329.70d9461a.froese@gmx.de>
	<20050606092608.GA16471@god.dyndns.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2005 11:26:08 +0200 Henk wrote:

| On Sun, Jun 05, 2005 at 12:53:29AM +0200, Edgar Toernig wrote:
| > By your reasoning /usr/dict/words had to be in the kernel,
| > too.
| 
| Well by my reasoning you should, if possible, define some usefull
| standards that will allow te reuse of these dictionaries within other
| applications.
| 
| And while we're on the subject of whats IN or OUT, (and I'll bet if you
| ask 10 kernel developers you'll get 10 answers but I try anyway ;)
| 
| In my philosophy the OS (kernel + device drivers) is an abstraction of
| the machine, it should present the 'machine' in such a way that allows
| for other abstractions such as a word processor to operate without having
| to know the specifics of hardware devices.

The abstraction also includes libraries, and if lib7segment
could do this from userspace, that's where it should reside.
I'm not saying that it can, but if it can, then that's the
desired place for it.

| To have a guideline on the 7 segments notation and to have a few defines
| that allow ASCII chars to be represented on 7 segments displays also help
| to support the 'machine' abstraction.
| 
| Wheter or not /usr/dict/words should be 'in the kernel' is not being
| discussed here, so I am not going to elaborate on that.
| 
| Cheers,
| 
| henk
| 
| 
| PS I am not on the list, so please use CC if you're interested in a response.
| PS Please excuse any spelling mistakes, I don't have a spelling checker
| installed...


---
~Randy
