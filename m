Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSKOAHj>; Thu, 14 Nov 2002 19:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbSKOAHj>; Thu, 14 Nov 2002 19:07:39 -0500
Received: from pheriche.sun.com ([192.18.98.34]:53460 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id <S265336AbSKOAHi>;
	Thu, 14 Nov 2002 19:07:38 -0500
Message-ID: <3DD43C65.80103@sun.com>
Date: Thu, 14 Nov 2002 16:14:29 -0800
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com> <200211150006.gAF06JF01621@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> Two questions.
> 
> 1. Why are arrays vmalloc-ed? This is a goochism which you have
>    to justify.

Because they can be as large as root allows, and when we used kmalloc() 
it would actually fail from time to time.

> 2. How do these changes sit with LLNL's changes to increase
>    number of groups that NFS client can support? It's not
>    a showstopper, but would be nice if you two cooperated.

hmm, I haven't heard anything about them - can you offer an email or URL?

Thanks


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

