Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbTEAAZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTEAAZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:25:57 -0400
Received: from [12.47.58.20] ([12.47.58.20]:61820 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262531AbTEAAZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:25:56 -0400
Date: Wed, 30 Apr 2003 17:35:08 -0700
From: Andrew Morton <akpm@digeo.com>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: greg@kroah.com, rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk10 blkmtd.c:219: warning: implicit declaration of
 function `alloc_kiovec'
Message-Id: <20030430173508.1d7a203d.akpm@digeo.com>
In-Reply-To: <1051749144.5630.2.camel@flat41>
References: <1051745126.5274.22.camel@flat41>
	<1051747119.5315.28.camel@flat41>
	<20030430171047.2f22ed70.akpm@digeo.com>
	<1051749144.5630.2.camel@flat41>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 00:38:11.0422 (UTC) FILETIME=[F1887FE0:01C30F79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Jaskiewicz <gj@pointblue.com.pl> wrote:
>
> On Thu, 2003-05-01 at 01:10, Andrew Morton wrote:
> 
> > 
> > blkmtd died when kiobufs were removed.  The maintainer said "oh well, OK, I
> > need to rewrite it anyway" but that obviously has not yet happened.
> 
> :/ 
> 
> So why we still have this in kernel ?

Waiting for the maintainer to fix it up.

> I don't have any of those devices, so i am not even able to correct
> this. If i will have, i will do so (at least try).

All it needs is a disk drive:

 * blkmtd.c - use a block device as a fake MTD


