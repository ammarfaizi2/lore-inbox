Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbTCGL0B>; Fri, 7 Mar 2003 06:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbTCGLZg>; Fri, 7 Mar 2003 06:25:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:5513 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261520AbTCGLZf>;
	Fri, 7 Mar 2003 06:25:35 -0500
Date: Fri, 7 Mar 2003 03:36:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: green@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [2.5] memleak in load_elf_binary?
Message-Id: <20030307033609.2e7fd993.akpm@digeo.com>
In-Reply-To: <20030307032532.17d37207.akpm@digeo.com>
References: <20030307141247.D7347@namesys.com>
	<20030307032532.17d37207.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 11:36:03.0478 (UTC) FILETIME=[BBFE0360:01C2E49D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> This needs a little thought, as we've already set the new personality and the
> old executable has been rubbed out.

Actually it looks to be fairly simple to fix.   Less simple to test...
