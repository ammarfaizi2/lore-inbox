Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267397AbSLER4D>; Thu, 5 Dec 2002 12:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267398AbSLER4D>; Thu, 5 Dec 2002 12:56:03 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:24592 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267397AbSLER4D>;
	Thu, 5 Dec 2002 12:56:03 -0500
Date: Thu, 5 Dec 2002 10:03:25 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.50
Message-ID: <20021205180324.GA3712@kroah.com>
References: <20021205163152.GA2865@kroah.com> <20021205163234.GB2865@kroah.com> <20021205171925.A31997@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205171925.A31997@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 05:19:25PM +0000, Christoph Hellwig wrote:
> On Thu, Dec 05, 2002 at 08:32:34AM -0800, Greg KH wrote:
> > ChangeSet 1.797.131.1, 2002/11/30 00:13:57-08:00, steve@kbuxd.necst.nec.co.jp
> > 
> > [PATCH] fs/namei.c fix
> > 
> > One of Greg KH's security cleanups reversed the sense of a test.
> > Without this patch, 2.5.50 oopses at boot.  Please apply.
> 
> Umm, that's already in mainline.

I know.  I had added it to my tree before Linus added it himself.  The
BK merge handled this just fine :)

thanks,

greg k-h
