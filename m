Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVBZTCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVBZTCa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 14:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVBZTCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 14:02:30 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:4322 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261261AbVBZS6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 13:58:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uQErR83dtCB0yiYjkCYa0JJxvXq0Dgvb5p8Gxg+qxVMwJgP2oKFlIo9gQqeE9aOxLSpDCAJSs1ZbZBxCfNpKMjR834KQe5hq/bcLuM9kSce+OXgHtpJMeyV0wo6SyQHJ9hXZlHM4Pa+gAotquQrf4uVFNpeBi5MidskWWyVsmAA=
Message-ID: <1458d96105022610581835e29e@mail.gmail.com>
Date: Sun, 27 Feb 2005 00:28:51 +0530
From: Sumit Narayan <talk2sumit@gmail.com>
Reply-To: Sumit Narayan <talk2sumit@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: USB IDE Connector
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050225223649.GA28014@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1458d96105022421001e006f5f@mail.gmail.com>
	 <20050225223649.GA28014@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, basically I would like to test the file system. And since I
travel I lot, I carry laptop and this external disk with me. So, was
just wondering if I could somehow conduct a disk-level test.

Thanks.


On Fri, 25 Feb 2005 14:36:49 -0800, Greg KH <greg@kroah.com> wrote:
> On Fri, Feb 25, 2005 at 10:30:27AM +0530, Sumit Narayan wrote:
> > Hi,
> >
> > I have an external IDE connector through USB port. Where could I get
> > the exact point inside the kernel, from where I would get information
> > such as Block No., Request size, partition details for a particular
> > request, _just_ before being sent to the disk.
> >
> > Like, for a normal IDE, I could gather these details from inside the
> > function __ide_do_rw_disk from "struct request". Is there anyway for
> > finding out the same for a USB mass storage device?
> 
> Why would you want to know this information for a controller device that
> acts like a scsi one, not an IDE one (that's what usb storage devices
> do...)
> 
> thanks,
> 
> greg k-h
>
