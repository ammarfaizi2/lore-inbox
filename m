Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbTBEWaX>; Wed, 5 Feb 2003 17:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbTBEWaX>; Wed, 5 Feb 2003 17:30:23 -0500
Received: from tsv.sws.net.au ([203.36.46.2]:23057 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S265096AbTBEWaW>;
	Wed, 5 Feb 2003 17:30:22 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Date: Wed, 5 Feb 2003 23:39:46 +0100
User-Agent: KMail/1.5
Cc: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, torvalds@transmeta.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
References: <200302051647.LAA05940@moss-shockers.ncsc.mil> <20030205220755.GA21652@kroah.com> <20030205223047.A30669@infradead.org>
In-Reply-To: <20030205223047.A30669@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302052339.46279.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003 23:30, Christoph Hellwig wrote:
> The main point is that LSM in the current shape, with every single policy
> detail left to the modules (compare that say to the linux filesystem code
> where we have lots of very different filesystems and still have as much as
> possible policy decision in the core code, this is one of the really strong
> points of Linux!) is a very bad idea and I _really_ don't want to see
> it in the next major stable release.

My understanding is that LSM was created at the request of Linus because there 
were several groups of people who had different patches for security policy 
in "core code".  Linus apparently didn't like that idea and requested a 
framework so that Linux would not be tied to one particular security model.  
Someone please correct me if my understanding of LSM history is incorrect.

Now as for the issue of code to use the hooks, SE Linux uses almost all the 
hooks and I'm sure that Steve can send in the appropriate patch at any 
time...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

