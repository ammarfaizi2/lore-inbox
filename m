Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSJYWvh>; Fri, 25 Oct 2002 18:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261677AbSJYWvh>; Fri, 25 Oct 2002 18:51:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:529 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261664AbSJYWvg>;
	Fri, 25 Oct 2002 18:51:36 -0400
Message-ID: <3DB9CC5D.7000600@pobox.com>
Date: Fri, 25 Oct 2002 18:57:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: Robert Love <rml@tech9.net>, Daniel Phillips <phillips@arcor.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
References: <F2DBA543B89AD51184B600508B68D4000ECE7086@fmsmsx103.fm.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:

>The notion of "SMT (Simultaneous Multi-Threaded)" architecture has been
>there for a while (at least 8 years, as far as I know). You would get tons
>of info if you search it in Internet. 
>  
>


Certainly.   That however does not imply that Robert's patch should read 
"number of threads" instead of "number of siblings."  The lone word 
"thread" does not automatically imply "active thread running on this 
virtual processor" or anything close to that.

"sibling" makes a lot more sense from an English language perspective.

    Jeff




