Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTEAABf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTEAABf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:01:35 -0400
Received: from [12.47.58.20] ([12.47.58.20]:29561 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262571AbTEAABe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:01:34 -0400
Date: Wed, 30 Apr 2003 17:10:47 -0700
From: Andrew Morton <akpm@digeo.com>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, rddunlap@osdl.org
Subject: Re: 2.5.68-bk10 blkmtd.c:219: warning: implicit declaration of
 function `alloc_kiovec'
Message-Id: <20030430171047.2f22ed70.akpm@digeo.com>
In-Reply-To: <1051747119.5315.28.camel@flat41>
References: <1051745126.5274.22.camel@flat41>
	<1051747119.5315.28.camel@flat41>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 00:13:50.0628 (UTC) FILETIME=[8AD50640:01C30F76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Jaskiewicz <gj@pointblue.com.pl> wrote:
>
>   struct kiobuf *iobuf;
> 	^^^^^^^
>   unsigned long *blocks;
> 
> Fast fgrep in kernel sources gives me no answer about this structure declaration.
> 

blkmtd died when kiobufs were removed.  The maintainer said "oh well, OK, I
need to rewrite it anyway" but that obviously has not yet happened.

