Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUCDLym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 06:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbUCDLym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 06:54:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:24466 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261850AbUCDLyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 06:54:41 -0500
Date: Thu, 4 Mar 2004 03:54:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel Mack <daniel@zonque.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc2: scripts/modpost.c
Message-Id: <20040304035427.727d3353.akpm@osdl.org>
In-Reply-To: <20040304113749.GD5569@zonque.dyndns.org>
References: <20040304113749.GD5569@zonque.dyndns.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Mack <daniel@zonque.org> wrote:
>
> as I found out, it's impossible to use the build-chain tool scripts/modpost
>  of the 2.6 kernel series to externally build modules from a directory that
>  contains the character sequence '.o'. Weird things happen if you try to do
>  so.
> 
>  With a directory structure like on my system here, building the current DVB
>  driver in '/home/daniel/cvs.linuxtv.org/dvb-kernel/build-2.6i/' generates a 
>  file called '/home/daniel/cvs.linuxtv.mod.c' since modpost cuts every 
>  filename string at the first occurence of '.o', not only the 'trailing .o',
>  as the comment says.

I tried your patch the other day and had weird compilation errors with x86
allyesconfig.   Could you check that?

