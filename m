Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265703AbSKATDd>; Fri, 1 Nov 2002 14:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265704AbSKATDc>; Fri, 1 Nov 2002 14:03:32 -0500
Received: from bozo.vmware.com ([65.113.40.131]:51728 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S265703AbSKATDb>; Fri, 1 Nov 2002 14:03:31 -0500
Date: Fri, 1 Nov 2002 11:11:42 -0800
From: chrisl@vmware.com
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sasha Malchik <sasha@vmware.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE CDROM packet command buffer size restriction.
Message-ID: <20021101191142.GA1431@vmware.com>
References: <20021101044646.GB8603@vmware.com> <20021101121045.GK8428@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101121045.GK8428@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 01:10:45PM +0100, Jens Axboe wrote:
> On Thu, Oct 31 2002, chrisl@vmware.com wrote:
> 
> Yes sorry, it's fallen through the cracks.

Thanks for your quick reply. I am sorry that I forget to CC you
on the mail, my bad.

> 
> > VMware try to use the generic packet interface (CDROM_SEND_PACKET)
> > for cdrom simulation. There are some packet command used by windows
> > can return different data size, depend on the type of CD in the CDROM.
> > Current linux kernel will fail the ioctl call if packet command return
> > data less than expected.
> > 
> > ide-scsi driver do not have this problem.
> > 
> > We make a patch allow kernel return successful and return the actual
> > transfer data size. Is it the prefer behavior in this case? If not,
> > what is the best way to solve this problem?
> 
> The patch does look good, thanks.

Thank you so much for evaluate the patch. Any idea which kernel it will
get in? We can update our support document:
"for complete raw cdrom support, please upgrade to kernel 2.4.xx or later."

> 
> I can only say resend and resend. It's no secret that I regurlarly loose
> patches and don't respond to emails, because there are just so many of
> them.

We all understand the importance of the resubmit mechanism now.
Actually every body here is very exciting about the patch been accepted.
It solve some long lasting problem and those ugly hack can go away soon.
That exactly why I love open source.

Thanks

Chris




