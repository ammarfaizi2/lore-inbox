Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSEZLSn>; Sun, 26 May 2002 07:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315969AbSEZLSm>; Sun, 26 May 2002 07:18:42 -0400
Received: from [203.117.131.12] ([203.117.131.12]:17638 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S315943AbSEZLSl>; Sun, 26 May 2002 07:18:41 -0400
Message-ID: <3CF0C48A.8010608@metaparadigm.com>
Date: Sun, 26 May 2002 19:18:34 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020520 Debian/1.0rc2-3
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kernel Newbies <kernelnewbies@nl.linux.org>
Subject: Re: How to invalidate pages mapped with nopage vm_operation
In-Reply-To: <3CEE5281.5000802@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got no reply from kernel-newbies. Any one can help me?

Do I use zap_page_range() ?? This doesn't seem to be
exported to modules. Any ideas what to do?

~mc

On 05/24/02 22:47, Michael Clark wrote:

> Hi,
>
> I have a char driver that implements mmap by overriding the
> nopage vm_operation (rather than using remap_page_range).
>
> What it the correct way to invalidate these mappings
> so I will re-take a fault on the next access to the addresses
> previously mapped by my nopage function?
>
> ~mc
>
>
>
> -- 
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
>


