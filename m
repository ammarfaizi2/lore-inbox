Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269237AbUICGfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbUICGfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 02:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269278AbUICGfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 02:35:38 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:38896 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269237AbUICGfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 02:35:31 -0400
Message-ID: <413810B6.7020805@namesys.com>
Date: Thu, 02 Sep 2004 23:35:34 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Steve Bergman <steve@rueb.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       reiserfs <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org>	 <200408282314.i7SNErYv003270@localhost.localdomain>	 <20040901200806.GC31934@mail.shareable.org>	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>	 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>	 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>	 <4136A14E.9010303@slaphack.com>	 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>	 <4136C876.5010806@namesys.com>	 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>	 <4136E0B6.4000705@namesys.com>  <14260000.1094149320@flay> <1094154744.12730.64.camel@voyager.localdomain> <4137BC3C.4010207@slaphack.com>
In-Reply-To: <4137BC3C.4010207@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>
> The use of ext3 as a filesystem isn't cross-platform.  Every disk-write
> is platform-specific!  We should all be using captive-ntfs instead!

;-)

All this stuff about how no filesystem should be allowed to have 
semantic features others don't, it seems very Bolshevist to me.

Let Linux have an ecosystem with a diverse ecology of filesystems, and 
the features that work will reproduce to other filesystems.  I thought 
that was the Linus way?

If not, why did I spend 10 years laying the storage layer groundwork for 
semantic enhancements when I could have taken that job at Sun as 
filesystems architect and made a lot more money?

I want to tinker.  Let me play in my sandbox, and if you don't like what 
I do, don't imitate it.....  I think there are plenty of users who like 
reiser4 though....

Linus, trying to outguess someone who has spent 2 decades studying 
namespace design as to what will be useful to users is risky.  Look at 
reiser4's performance, see if it obsoletes V3, and if it does then let 
me play a bit.

Objecting on the grounds that it causes VFS bugs is reasonable, but I 
answered those questions and you did not respond (I can resend if 
asked).  If you really really don't like what we do to VFS, well, we can 
confine ourselves to sys_reiser4(), but that is only a last resort from 
my view.

Hans
