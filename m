Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVAFLLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVAFLLt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 06:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVAFLLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 06:11:48 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:56078 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262811AbVAFLLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 06:11:41 -0500
Message-ID: <41DD1ECF.5060005@hist.no>
Date: Thu, 06 Jan 2005 12:19:43 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2 error: redefinition of `struct cfq_io_context'
References: <20050106002240.00ac4611.akpm@osdl.org>
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/
>
>- Various minorish updates and fixes
>
>  
>
CC      init/do_mounts_md.o
In file included from include/linux/raid/md.h:21,
                 from init/do_mounts_md.c:2:
include/linux/blkdev.h:71: error: redefinition of `struct cfq_io_context'
make[1]: *** [init/do_mounts_md.o] Error 1
make: *** [init] Error 2

