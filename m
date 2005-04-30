Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263122AbVD3CCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbVD3CCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 22:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbVD3CCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 22:02:33 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:4061 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263122AbVD3CC2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 22:02:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cwnm6pKYeG/Dpv4JgupzN32MzRy553+q3JCQyPLk93tQVMamdft5XWnvNKTJphF++k8DCmGN0Igo1sR2XlZ2T6cg75B4LF8NUA42A17HIjl0KFezHhpYBSFbdBwFtpP3MLnHdDvsizIa4Z11EPR9LnmT7LePq+YyYg05YkoAa3Y=
Message-ID: <9cde8bff05042919025d077eb1@mail.gmail.com>
Date: Sat, 30 Apr 2005 11:02:27 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] fs/Kconfig: more consistent configuration of XFS
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050429212835.GD8699@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9cde8bff050428005528ecf692@mail.gmail.com>
	 <20050428080914.GA10799@infradead.org>
	 <9cde8bff0504280138b979c08@mail.gmail.com>
	 <20050428083922.GA11542@infradead.org>
	 <9cde8bff05042802213ec650e0@mail.gmail.com>
	 <20050429212835.GD8699@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/05, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Thu, Apr 28, 2005 at 06:21:52PM +0900, aq wrote:
> >
> > OK, here is another patch. It is up to Andrew to pick the approriate.
> > But I still prefer the first patch, which provides both consistency in
> > interface and configuration.
> 
> We shall do out best to distribute info to places where it belongs.
> A much better approch would be to move all ext2 + ext3 stuff out in
> their respective directories.
> When modifying xfs (or ext2,ext3) no files outside their respective
> directories should in need to be touched - this would just impose
> additional burden doing parrallel development.

OK, I agree.

> 
> About your modifications:
> 
> Skipping the menu part is OK.
> While you are modifying Kconfig in xfs/ put a
> 
> if XFS_FS
> ...
> endif
> 
> around all config options expcept the one defining the XFS_FS option.
> This will fix menu identing.

Thanks for pointing this out. But the patch I posted is fair enough.
It just move one menu item around, and change nothing else. Are you
happy with it?

regards,
aq
