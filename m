Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTEHVjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbTEHVjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:39:25 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:46759 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262139AbTEHVjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:39:24 -0400
Date: Thu, 8 May 2003 14:48:08 -0700
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove devfs_register
Message-Id: <20030508144808.745328f5.akpm@digeo.com>
In-Reply-To: <20030508223449.A29413@lst.de>
References: <20030508223449.A29413@lst.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 May 2003 21:51:56.0481 (UTC) FILETIME=[0B4F4B10:01C315AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> Whee! devfs_register isn't used anymore in the whole tree

devfs_register appears to still be used in

./arch/ia64/sn/io/sn2/xbow.c
./arch/ia64/sn/io/hcl.c
./arch/ia64/sn/io/pciba.c
