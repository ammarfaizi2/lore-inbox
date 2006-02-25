Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWBYGUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWBYGUx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWBYGUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:20:53 -0500
Received: from fgwmail.fujitsu.co.jp ([164.71.1.133]:22734 "EHLO
	fgwmail.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932151AbWBYGUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:20:52 -0500
Date: Sat, 25 Feb 2006 15:22:18 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_online_pgdat (take2)  [1/5]  define
 for_each_online_pgdat
Message-Id: <20060225152218.a9e74acf.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060224221651.58950b8c.akpm@osdl.org>
References: <20060225150528.98386921.kamezawa.hiroyu@jp.fujitsu.com>
	<20060224221651.58950b8c.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006 22:16:51 -0800
Andrew Morton <akpm@osdl.org> wrote:

 >  +	}
> >  +	return zone;
> >  +}
> 
> Some of these things must generate a large amount of code - would you have
> time to look into uninlining them, see what impact that has on .text size?

Okay, I'll do soon on ia64.

Thanks,
-- Kame

