Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTJQC6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 22:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTJQC6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 22:58:05 -0400
Received: from dyn-ctb-210-9-243-144.webone.com.au ([210.9.243.144]:57092 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263293AbTJQC6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 22:58:03 -0400
Message-ID: <3F8F5A53.50209@cyberone.com.au>
Date: Fri, 17 Oct 2003 12:56:19 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: decaying average for %CPU
References: <1066358155.15931.145.camel@cube>
In-Reply-To: <1066358155.15931.145.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Albert Cahalan wrote:

>The UNIX standard requires that Linux provide
>some measure of a process's "recent" CPU usage.
>Right now, it isn't provided. You might run a
>CPU hog for a year, stop it ("kill -STOP 42")
>for a few hours, and see that "ps" is still
>reporting 99.9% CPU usage. This is because the
>kernel does not provide a decaying average.
>

I think the kernel provides enough info for userspace to do
the job, doesn't it?


