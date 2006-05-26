Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWEZVVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWEZVVq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWEZVVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:21:46 -0400
Received: from quechua.inka.de ([193.197.184.2]:44470 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751578AbWEZVVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:21:46 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Intercept write to disk
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <1148676730.2094.10.camel@localhost>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Fjjke-0000EV-00@calista.inka.de>
Date: Fri, 26 May 2006 23:21:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mishael A Sibiryakov <death@junki.org> wrote:
> Probably i have a stupid question but i can't find adequate solution for
> it. I want to intercept write to real disk partition or entire disk
> (except of swap partition of course). As i understood vfs and Co i think
> that i need to work on level between fs driver and disk driver. But it's
> unclean for me. Please tell me is it possible and if possible then say
> how or put me to some documentation.

You can write a devmapper module, or maybe pre-load a shared user mode
library.

Gruss
Bernd
