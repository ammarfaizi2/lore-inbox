Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTEGWqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTEGWqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:46:24 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:7723 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264156AbTEGWqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:46:24 -0400
Date: Wed, 7 May 2003 15:55:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: Nicolas <linux@1g6.biz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slab oops with 2.5.69
Message-Id: <20030507155512.0cc146a1.akpm@digeo.com>
In-Reply-To: <200305072317.47119.linux@1g6.biz>
References: <200305072317.47119.linux@1g6.biz>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 22:58:54.0104 (UTC) FILETIME=[3B962980:01C314EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas <linux@1g6.biz> wrote:
>
> Last user: [<d3a18226>](0xd3a18226)

We need to know which module was the last one to play with that size-32
object.

Which modules were loaded, and had been in use?
