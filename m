Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291394AbSCMAm7>; Tue, 12 Mar 2002 19:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291401AbSCMAmu>; Tue, 12 Mar 2002 19:42:50 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:25340 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S291394AbSCMAmi>; Tue, 12 Mar 2002 19:42:38 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3C8E6C63.E8B72195@zip.com.au> 
In-Reply-To: <3C8E6C63.E8B72195@zip.com.au>  <3C8D9999.83F991DB@zip.com.au>, <3C8D9999.83F991DB@zip.com.au> <E16kkcq-0001rV-00@starship> 
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Mar 2002 00:42:15 +0000
Message-ID: <5812.1015980135@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


akpm@zip.com.au said:
>  Really, I don't think we can lose page->buffers for *enough* users of
> address_spaces to make it worthwhile.

> If it was only being used for, say, blockdev inodes then we could
> perhaps take it out and hash for it, but there are a ton of
> filesystems out there... 

I have plenty of boxes which never have any use for page->buffers. Ever.

--
dwmw2


