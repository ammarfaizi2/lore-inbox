Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVAFIj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVAFIj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 03:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVAFIj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 03:39:58 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:56751 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262778AbVAFIjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 03:39:52 -0500
Message-ID: <41DCF953.4030206@yahoo.com.au>
Date: Thu, 06 Jan 2005 19:39:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
References: <20050106002240.00ac4611.akpm@osdl.org>
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/
> 

...

> +kexec-kexecx86_64-4level-fix-unfix.patch
> 
>  Hack to make x86_64 compile.  Will break kexec.
> 

It should be enough to just change the ->pml4 to ->pgd. Assuming that it
worked with the original 4level patches.
