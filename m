Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbUKRSaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbUKRSaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbUKRS35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:29:57 -0500
Received: from mail.shareable.org ([81.29.64.88]:49540 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262843AbUKRS2i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:28:38 -0500
Date: Thu, 18 Nov 2004 18:28:14 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, hbryan@us.ibm.com, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041118182814.GB29736@mail.shareable.org>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Why do you think it would kill the FUSE process? And why do you think 
> killing _any_ process would make the system come back to life? After all, 
> memory wasn't filled by process usage, it was filled by dirty FS pages.
> 
> I really do believe that user-space filesystems have problems. There's a 
> reason we tend to do them in kernel space. 

Are kernel space filesystems immune from this problem?  What happens
when they need to kmalloc() in order to write some data?

-- Jamie
