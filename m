Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbTIKEvV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266061AbTIKEvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:51:21 -0400
Received: from dyn-ctb-203-221-74-143.webone.com.au ([203.221.74.143]:2821
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S266058AbTIKEvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:51:17 -0400
Message-ID: <3F5FFF3D.9040707@cyberone.com.au>
Date: Thu, 11 Sep 2003 14:51:09 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Local DoS on single_open?
References: <3741.1063255333@kao2.melbourne.sgi.com>
In-Reply-To: <3741.1063255333@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Keith Owens wrote:

>single_open() requires the kernel to kmalloc a buffer which lives until
>the userspace caller closes the file.  What prevents a malicious user
>opening the same /proc entry multiple times, allocating lots of kmalloc
>space and causing a local DoS?
>  
>

ulimit?


