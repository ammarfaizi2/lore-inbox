Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTE0Uj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTE0UjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:39:11 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40916 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264144AbTE0Uit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:38:49 -0400
Date: Tue, 27 May 2003 13:49:46 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm1
Message-Id: <20030527134946.7ffd524d.akpm@digeo.com>
In-Reply-To: <200305271633.40421.tomlins@cam.org>
References: <20030527004255.5e32297b.akpm@digeo.com>
	<200305271238.25935.m.c.p@wolk-project.de>
	<200305271633.40421.tomlins@cam.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 20:52:02.0801 (UTC) FILETIME=[D3287E10:01C32491]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> Hi Andrew,
> 
> This one oops on boot 2 out of 3 tries.  
> 
> ...
> EIP is at load_module+0x7c5/0x800

-mm has modules changes.  Is CONFIG_DEBUG_PAGEALLOC enabled?
