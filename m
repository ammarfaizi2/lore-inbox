Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265001AbUGGHXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbUGGHXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 03:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUGGHXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 03:23:14 -0400
Received: from quechua.inka.de ([193.197.184.2]:51632 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265001AbUGGHXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 03:23:10 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: possible arp table corruption [2.4.18]
Organization: Deban GNU/Linux Homesite
In-Reply-To: <13e9886104070615087452e595@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Bi6lo-0001Hp-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 07 Jul 2004 09:23:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <13e9886104070615087452e595@mail.gmail.com> you wrote:
> Where is the bug? What should I do to avoid this?

Probably in the line generation code of the /proc file in (your old) kernel,
and you can (still) avoid it with netlink. Or you need to read multiple
times through the table.

Another option would be to use a user space arp daemon to catch changes of
the table.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
