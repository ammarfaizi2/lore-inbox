Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281974AbRKUUjL>; Wed, 21 Nov 2001 15:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281975AbRKUUjA>; Wed, 21 Nov 2001 15:39:00 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:3568 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281974AbRKUUiy>; Wed, 21 Nov 2001 15:38:54 -0500
Message-ID: <3BFC10DB.4070705@redhat.com>
Date: Wed, 21 Nov 2001 15:38:51 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Merkey <jmerkey@timpanogas.org>
CC: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
In-Reply-To: <E166S8l-0007hs-00@fenrus.demon.nl> <002401c172ba$b46bed20$f5976dcf@nwfs> <3BFBFB4F.8090403@redhat.com> <002101c172c5$f2040cc0$f5976dcf@nwfs>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Merkey wrote:

> Doug,
> 
> I have seen some problems with the rpm build and default install of your
> kernel sources.
> NWFS and the SCI drivers will **NOT** build against it since you post in a
> linux and linux-up kernel for lilo during boot. 


It would if you used my module build kit.

> People using these drivers
> who email me always have to do a "make distclean" to get stuff to build. 


They (and you) think they do, but they don't.

> I
> am very familiar with the kernel.h
> changes you guys put in that are different from stock kernels, but despite
> this, it's
> far from "plug and play" for a customer building third party kernel modules
> on your rpms.



See my build kit (which has been available since 6.2 incidentally). 
Very plug and play for a kernel developer.






-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

