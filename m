Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTDQAw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 20:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbTDQAw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 20:52:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:209 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262000AbTDQAw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 20:52:57 -0400
Message-ID: <3E9DFDA8.1000102@pobox.com>
Date: Wed, 16 Apr 2003 21:04:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
References: <3E9DFC11.50800@pobox.com>
In-Reply-To: <3E9DFC11.50800@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Linus,
> 
> Please review the patch below, then do a
> 
>     bk pull http://gkernel.bkbits.net/misc-2.5
> 
> Summary:
> 
> gcc's __builtin_memcpy performs the same function (and more) as the 
> kernel's __constant_memcpy.  So, let's remove __constant_memcpy, and let 
> the compiler do it.


Oh, and __builtin_memcpy exists on gcc 2.95.x, which is the current 2.5 
minimum.

	Jeff



