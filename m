Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUBRHmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUBRHmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:42:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:60073 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263607AbUBRHmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:42:08 -0500
Date: Tue, 17 Feb 2004 23:43:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.3-mm1
Message-Id: <20040217234314.1cbe76c3.akpm@osdl.org>
In-Reply-To: <20040217232130.61667965.akpm@osdl.org>
References: <20040217232130.61667965.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm1/

oops, it appears that rmmod hangs in D state all the time.  

root      1381  0.0  0.0     0    0 ?        SW<  23:33   0:00  \_ [kstopmachine]
root      1382  0.0  0.0     0    0 ?        Z<   23:33   0:00      \_ [kstopmachine <defunct>]
root      1380  0.0  0.1  1356  392 pts/0    D    23:33   0:00  |           \_ rmmod 3c59x


