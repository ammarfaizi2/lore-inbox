Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280524AbRKTD3d>; Mon, 19 Nov 2001 22:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280856AbRKTD3O>; Mon, 19 Nov 2001 22:29:14 -0500
Received: from quechua.inka.de ([212.227.14.2]:30330 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S280839AbRKTD3I>;
	Mon, 19 Nov 2001 22:29:08 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: VM tuning for Linux routers
In-Reply-To: <20011118145400.A23181@se1.cogenit.fr>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E1661at-0005cw-00@calista.inka.de>
Date: Tue, 20 Nov 2001 04:29:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011118145400.A23181@se1.cogenit.fr> you wrote:
>> You can increase the reserved free memory (not sure where to do this in
> This reserve isn't dedicated to networking alas.

But it is for atomic kernel memory requests, which happen to be caused by
Interrupt handlers. On a Network loaded Box most of them are from the NICs.

Greetings
Bernd
