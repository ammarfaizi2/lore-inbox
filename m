Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTGBTLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 15:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTGBTLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 15:11:08 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:623 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264407AbTGBTLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 15:11:06 -0400
Date: Wed, 2 Jul 2003 12:20:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cryptoloop
Message-Id: <20030702122012.0c5ad0a6.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0307021215250.13353-100000@home.osdl.org>
References: <20030702120228.13d72290.akpm@digeo.com>
	<Pine.LNX.4.44.0307021215250.13353-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2003 19:25:31.0069 (UTC) FILETIME=[B3840ED0:01C340CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> On Wed, 2 Jul 2003, Andrew Morton wrote:
> > 
> > (Where are the first and second patches btw?  Merged?  Is a fourth
> > anticipated?)
> 
> The two first ones are merged.

Well please don't let me stand in the way of #3.  But we shouldn't lose
sight of the need to fix up these shortcomings.  pagecache&BIO use
pageframes and crypto uses pageframes.  Connecting them together via
virtual addresses is daft.


