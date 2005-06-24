Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbVFXCcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbVFXCcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 22:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVFXCcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 22:32:14 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:16555 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262989AbVFXCbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 22:31:48 -0400
X-IronPort-AV: i="3.93,225,1115017200"; 
   d="scan'208"; a="193881628:sNHT29090732"
Message-ID: <42BB7083.2070107@cisco.com>
Date: Fri, 24 Jun 2005 12:31:31 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com>
In-Reply-To: <42BB5E1A.70903@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>So you fundamentally reject the prototype it in one fs and then abstract
>it to others development model?
>  
>

Hans,
after many years here now, one would have thought you would have "got" 
this part of Linux: kernel development & code that gets into the kernel 
only does so by getting past the benevolent dictators.
instead, it seems that every time there is ReiserFS to be merged (and we 
can go back in history a number of years here..), it always seems to 
come as a great shock that your code won't be merged 'as-is' without 
peer review & comment.

don't feel that you're being singled out here.  you aren't.  there isn't 
any anti-Hans-and-his-filesystem conspiracy here.
there are plenty of examples on where this has happened in Linux 
previously in other parts of the tree.
EVMS is a great example of similar things - a proposal to include kernel 
code to do various volume-mgmt functions - which was basically 
accomplishing the same goal as that of LVM/LVM2 and MD drivers (& DM 
framework).
the EVMS team are a great act to follow -  see 
http://lwn.net/Articles/14714/ - they showed high levels of professional 
conduct and made what was essentially a 'hard' but 'correct' decision in 
reworking EVMS to use the same DM infrastructure as LVM2.
there are countless other examples at various times - various 
'competing' IPv6 projects, IPSec, various "hardware" (software) RAID 
controllers, various IP offload schemes et al.

why does Reiserfs have to be any different?

you know that VFS is the mechanism in Linux.  you know (i hope..) how it 
works.  it isn't so hard to see how many of the Reiser4 "plug-ins" could 
be tied into VFS calls.
OR, if they cannot TODAY, propose how VFS _COULD_ be made to do this.

the key here is trust.  and trust is a two-way street.

the irony of this whole thread is that history is repeating itself.  see 
http://www.ussg.iu.edu/hypermail/linux/kernel/0112.1/0519.html
kernel developers pushed back on you 3 years ago - in 2001 - what has 
really changed?

*an observation*

cheers,

lincoln.
