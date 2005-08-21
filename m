Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVHULrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVHULrI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 07:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVHULrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 07:47:07 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:3628 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750965AbVHULrG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 07:47:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tth6t6/ctPchJPb/X5PKl4+uny/l2wjly7EmLYniDbHjKWD7Ho/n10vBqrDTzSyHNCXOp2OkfT4FLCBUsHrC5HmELomJGVTQrGgW6sNyDNHYQUfgz70T2+rg1wjAlXaRHt585DrtJqT6Ie2LbQX/w7iAagjjR7XWq/yGtQArzW4=
Message-ID: <9a87484905082104477cae9ba4@mail.gmail.com>
Date: Sun, 21 Aug 2005 13:47:06 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: use of uninitialized pointer in jffs_create()
Cc: linux-kernel@vger.kernel.org, jffs-dev@axis.com
In-Reply-To: <20050821091401.GA23626@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a87484905082015284c1686ec@mail.gmail.com>
	 <20050821091401.GA23626@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Sun, Aug 21, 2005 at 12:28:08AM +0200, Jesper Juhl wrote:
> > gcc kindly pointed me at jffs_create() with this warning :
> >
> > fs/jffs/inode-v23.c:1279: warning: `inode' might be used uninitialized
> > in this function
> 
> I don't see a warning with latest gcc-4.1 snapshot.
> 

I'm using gcc 3.3.6, and the kernel that shows this warning is 2.6.13-rc6-mm1


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
