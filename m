Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTFYHEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 03:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTFYHEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 03:04:47 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:63109 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263011AbTFYHEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 03:04:47 -0400
Date: Wed, 25 Jun 2003 00:19:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
Message-Id: <20030625001950.16bbb688.akpm@digeo.com>
In-Reply-To: <3EF94672.3030201@aros.net>
References: <3EF94672.3030201@aros.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2003 07:18:56.0813 (UTC) FILETIME=[0A6C3DD0:01C33AEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz <ldl@aros.net> wrote:
>
> That said, this seems like an opportunistic time to further break 
>  compatibility with the existing nbd-client user tool and  do away with 
>  the problematic components of the ioctl user interface.

Is a suitably modified userspace tool available?
