Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTJaJ1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTJaJ1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:27:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:65507 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263151AbTJaJ1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:27:48 -0500
Date: Fri, 31 Oct 2003 01:29:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: ahuisman@cistron.nl, linux-kernel@vger.kernel.org, nuno.silva@vgertech.com
Subject: Re: READAHEAD
Message-Id: <20031031012946.3adedc14.akpm@osdl.org>
In-Reply-To: <20031031012846.48fa233c.akpm@osdl.org>
References: <bnrdqi$uho$1@news.cistron.nl>
	<20031030134407.0c97c86e.akpm@osdl.org>
	<3FA25377.3050207@cistron.nl>
	<20031031012846.48fa233c.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Please, just use time, cat, dd, etc.
> 
>  	mount /dev/xxx /mnt/yyy
>  	dd if=/dev/zero of=/mnt/yyy/x bs=1M count=1024
>  	umount /dev/xxx
>  	mount /dev/xxx /mnt/yyy
>  	time cat /mnt/yyy/x > /dev/null

And you can do the same against /dev/hdaN if you have a scratch
partition; that would be interesting.
