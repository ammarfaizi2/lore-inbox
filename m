Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTGKS7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265072AbTGKS7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:59:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:42184 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265091AbTGKSwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:52:55 -0400
Date: Fri, 11 Jul 2003 12:00:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: piggin@cyberone.com.au, rathamahata@php4.ru, linux-kernel@vger.kernel.org
Subject: Re: Very HIGH File & VM system latencies and system stop responding
 while extracting big tar  archive file.
Message-Id: <20030711120054.52c1902b.akpm@osdl.org>
In-Reply-To: <20030711183950.GB976@matchmail.com>
References: <3F0E8A22.6020700@cyberone.com.au>
	<20030711034510.30065dc2.akpm@osdl.org>
	<20030711183950.GB976@matchmail.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> > No, this will be the reiserfs bug.
> 
> Is this in 2.5.75, or -mm?

2.5.75 needs the patch.

You are, as always, better off using the latest kernel.  That's 2.5.75 plus
the "gzipped full patch" from
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/

It has the reiserfs fix.
