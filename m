Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273328AbRI1IP2>; Fri, 28 Sep 2001 04:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273329AbRI1IPS>; Fri, 28 Sep 2001 04:15:18 -0400
Received: from chiara.elte.hu ([157.181.150.200]:48910 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S273328AbRI1IPK>;
	Fri, 28 Sep 2001 04:15:10 -0400
Date: Fri, 28 Sep 2001 10:13:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Bobby Hitt <bobhitt@bscnet.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2GB File limitation
In-Reply-To: <013801c147e5$3330bec0$092cdb3f@bobathome>
Message-ID: <Pine.LNX.4.33.0109281011010.2517-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Bobby Hitt wrote:

> Is someone working on a way to overcome the 2GB file limitation in
> Linux? I currently backup several servers using a dedicated hard drive
> for the backups. Recently I saw one backup die saying the the file
> size had been exceeded. I've never had good luck with tape backups,
> yes they backup, but whenever I really need a file, it can't be
> retrieved.

file sizes up to ~ 2 TB are supported under the 2.4 kernel. (or 2.2 kernel
+ patches) Most utilities are updated to use O_LARGEFILE properly, in any
recent 2.4-based Linux distribution. I regularly use 6-10 GB files.

	Ingo

