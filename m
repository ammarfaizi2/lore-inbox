Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSJHSiu>; Tue, 8 Oct 2002 14:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbSJHSiu>; Tue, 8 Oct 2002 14:38:50 -0400
Received: from packet.digeo.com ([12.110.80.53]:12261 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261448AbSJHSiR>;
	Tue, 8 Oct 2002 14:38:17 -0400
Message-ID: <3DA32767.1F0C582F@digeo.com>
Date: Tue, 08 Oct 2002 11:43:51 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Annala <gval@mbnet.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page_alloc.c and mincore.c
References: <001101c26ef8$fcd41f20$4fa564c2@windows>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 18:43:51.0446 (UTC) FILETIME=[A5549B60:01C26EFA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Annala wrote:
> 
> This one removes a strange unused parameter in balance_classzone() and
> also slightly cleans up __alloc_pages().
> 

You're right.  We've significantly redone that code in
the -mm patchset, including cleaning up that stuff.

> ------------------------------
> 
> This one fixes a typo in mm/mincore.c

barf.  Nasty bug.  Thanks.
