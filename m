Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTIQAE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 20:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTIQAE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 20:04:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:24712 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262563AbTIQAE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 20:04:56 -0400
Date: Tue, 16 Sep 2003 16:46:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 3com problems
Message-Id: <20030916164613.1d6ea7a4.akpm@osdl.org>
In-Reply-To: <20030916235104.GA27089@schottelius.org>
References: <20030916235104.GA27089@schottelius.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius <nico-kernel@schottelius.org> wrote:
>
> since using test2 the 3com cards 3c90x transfer _very_ slow.
> this is reported by a friend a verified here.
> 2.4.22 is fine.
> 
> any changes in test3-test5?

Some.   Try the 2.6.0-test2 3c59x.c in the 2.6.0-test5 kernel.

If that's no good, try disabling ACPI.

