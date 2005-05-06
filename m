Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVEFIEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVEFIEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 04:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVEFIEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 04:04:53 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:36882 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261170AbVEFIEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 04:04:41 -0400
Date: Fri, 6 May 2005 10:04:37 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Joe <joecool1029@gmail.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Empty partition nodes not created (was device node issues with recent mm's and udev)
Message-ID: <20050506080437.GE4604@pclin040.win.tue.nl>
References: <d4757e6005050219514ece0c0a@mail.gmail.com> <20050503031421.GA528@kroah.com> <20050502202620.04467bbd.rddunlap@osdl.org> <d4757e600505022118131ec083@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4757e600505022118131ec083@mail.gmail.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 12:18:05AM -0400, Joe wrote:
> On 5/2/05, Randy.Dunlap <rddunlap@osdl.org> wrote:
> > Could this 2.6.11.8 -stable patch fix it?
> > Subject: [04/07] partitions/msdos.c fix
> > 
> > Joe, can you test 2.6.11.8, please?
> > 
> > ---
> > ~Randy
> > 
> 
> Randy, Can't run vanilla at the moment on this setup, any way you can
> get the patch seperate?  I also don't think that will fix it because
> this is an empty, not a msdos partition.
> 
> Thanks,
> Joe

There is a misunderstanding in terminology here.
"DOS-type partition table" is for most Linux users the only type
they have ever seen. The msdos in this context does not refer
to a particular filesystem, like the fat or msdos filesystem.

In case you have a problem because you want to access this partition,
give it some nonzero type.

Andries
