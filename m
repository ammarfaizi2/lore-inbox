Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTDUV55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTDUV55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:57:57 -0400
Received: from [12.47.58.203] ([12.47.58.203]:48516 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262629AbTDUV5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:57:55 -0400
Date: Mon, 21 Apr 2003 15:08:09 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ernie Petrides <petrides@redhat.com>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 fs/ext3/super.c fix for orphan recovery error
 path
Message-Id: <20030421150809.22d21362.akpm@digeo.com>
In-Reply-To: <200304212014.h3LKE4bP002830@pasta.boston.redhat.com>
References: <200304212014.h3LKE4bP002830@pasta.boston.redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2003 22:09:54.0363 (UTC) FILETIME=[BCC148B0:01C30852]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ernie Petrides <petrides@redhat.com> wrote:
>
> Stephen/Andrew, please consider applying this patch to reverse the order
> of checks in ext3_orphan_cleanup() for read-only mounts and prior errors.
> 

Thanks, that is definitely needed.  We should do this in 2.4 as well.

