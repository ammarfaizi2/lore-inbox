Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbUBBXsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUBBXsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:48:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:35774 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263523AbUBBXsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:48:37 -0500
Date: Mon, 2 Feb 2004 15:49:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: philip@codematters.co.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
Message-Id: <20040202154959.283cf60b.akpm@osdl.org>
In-Reply-To: <401EDEF2.6090802@cyberone.com.au>
References: <87oesieb75.fsf@codematters.co.uk>
	<20040201151111.4a6b64c3.akpm@osdl.org>
	<401D9154.9060903@cyberone.com.au>
	<87llnm482q.fsf@codematters.co.uk>
	<401DDCD7.3010902@cyberone.com.au>
	<401E1131.6030608@cyberone.com.au>
	<87d68xcoqi.fsf@codematters.co.uk>
	<401EDEF2.6090802@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> Andrew, any other ideas?

There seems to be a lot more writeout happening.

You could try setting /proc/sys/vm/dirty_ratio to 60 and
/proc/sys/vm/dirty_background_ratio to 40.

