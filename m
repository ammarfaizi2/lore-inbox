Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVAXWGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVAXWGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVAXWEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:04:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:40908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261678AbVAXWAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:00:33 -0500
Date: Mon, 24 Jan 2005 14:05:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: axboe@suse.de, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       lennert.vanalboom@ugent.be
Subject: Re: Memory leak in 2.6.11-rc1?
Message-Id: <20050124140507.1761792b.akpm@osdl.org>
In-Reply-To: <1106528219.867.22.camel@boxen>
References: <20050121161959.GO3922@fi.muni.cz>
	<1106360639.15804.1.camel@boxen>
	<20050123091154.GC16648@suse.de>
	<20050123011918.295db8e8.akpm@osdl.org>
	<20050123095608.GD16648@suse.de>
	<20050123023248.263daca9.akpm@osdl.org>
	<1106528219.867.22.camel@boxen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@dsv.su.se> wrote:
>
> I put something similar together of what you described but I made it a 
> proc-file. It lists all pages owned by some caller and keeps a backtrace
> of max 8 addresses.
> ...
> I hope you like it ;)

I do!  If you have time, please give it all a real config option under the
kernel-hacking menu and I'll sustain it in -mm, thanks.
