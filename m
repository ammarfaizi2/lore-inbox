Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270749AbTG0Lld (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270750AbTG0Lld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:41:33 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:39876 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S270749AbTG0Llc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:41:32 -0400
Message-ID: <3F23BE18.5000600@softhome.net>
Date: Sun, 27 Jul 2003 13:57:12 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: Vanilla not for embedded?! Re: Kernel 2.6 size increase -
 get_current()?
References: <dbTZ.5Z5.19@gated-at.bofh.it> <3F214EC3.9010804@softhome.net> <20030725204613.GB1686@matchmail.com>
In-Reply-To: <20030725204613.GB1686@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> Vanilla will be what people put into it.  And I have seen more messages from
> embedded people complaining, than actually doing and submitting patches for
> merging.
> 
> So the embedded trees are a deep fork huh?  Did you or anyone else do
> anything to merge during 2.5?!
> 
> And now you see why there is a "deep" fork...
> 

   Real-time stuff is a must - something like RTAI.
   Things like Linux Trace Toolkit - soone or later you have to start 
using them to tune performace.
   Patches to remove mandatory (for 2.2/2.0) PCI/IDE support were pretty 
common too.
   Patch to shrink network hashes - norm of life.
   Patch to kill PCI names database.
   And this is only things I was using personally (and I remember about) 
in my short 4 years carrier.

   CONFIG_TINY - http://lwn.net/Articles/14186/ - got something like 
this merged? - so I'm the first guy in the download queue on ftp.kernel.org!

   Kernel heavily tuned for servers and workstations (read - modern PCs).

   At my previous position company was using kernel prepared by Karim 
Yaghmour and right now we using kernels from MontaVista.
   Far from vanillas.

 > embedded people complaining

   Sure complaining.
   For some reasons all "improvements" to kernel had lead to increase of 
kernel size, not decrease. Strange, isn't it?


