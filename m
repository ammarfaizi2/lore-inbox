Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTDVIWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbTDVIWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:22:44 -0400
Received: from [12.47.58.232] ([12.47.58.232]:26802 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263015AbTDVIWn (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 22 Apr 2003 04:22:43 -0400
Date: Tue, 22 Apr 2003 01:35:19 -0700
From: Andrew Morton <akpm@digeo.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux-Kernel@Vger.Kernel.ORG, Torvalds@Transmeta.COM
Subject: Re: [PATCH] (one line): use #ifdef with CONFIG_*
Message-Id: <20030422013519.23754c14.akpm@digeo.com>
In-Reply-To: <16036.64756.25228.181408@laputa.namesys.com>
References: <16036.64756.25228.181408@laputa.namesys.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2003 08:34:43.0137 (UTC) FILETIME=[05CE3B10:01C308AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
> -#if CONFIG_DEBUG_HIGHMEM
> +#ifdef CONFIG_DEBUG_HIGHMEM

mnm:/usr/src/linux-2.5.68> grep -r '#if[        ]*CONFIG' . | wc -l
    185

Why fix this one in particular?
