Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288725AbSAICc1>; Tue, 8 Jan 2002 21:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288726AbSAICcR>; Tue, 8 Jan 2002 21:32:17 -0500
Received: from quechua.inka.de ([212.227.14.2]:24358 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S288725AbSAICcF>;
	Tue, 8 Jan 2002 21:32:05 -0500
From: Bernd Eckenfels <ecki-news2002-01@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem creation problems with 2.4.17
In-Reply-To: <20020109014216.GB4511@flounder.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16O8X8-0006yJ-00@sites.inka.de>
Date: Wed, 9 Jan 2002 03:32:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020109014216.GB4511@flounder.net> you wrote:
> adam@braindb:~$ sudo mke2fs /dev/sda9
...
> File size limit exceeded

It is a problem with sudo. Use another way to obtain root, like local root
login. The reason is a wrong setrlimit call in sudo.

Greetings
Bernd
