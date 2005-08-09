Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVHIJ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVHIJ6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVHIJ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:58:21 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:30994 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932501AbVHIJ6U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:58:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H/CYjN3ehkJCanpxP+yTEdR2bpOLfmPwuvTafuExHvazcgfo767DxBfMoJVod2TIrENg3UrhQF+bfDvorEnsDZER3EEiENQnCwJLsY12b/afVYnIjo67TDhxUBddb3YFkBUijB9f0FsByDBx61G33cte1wDmJ2nzv7hrk8U4BBs=
Message-ID: <4af2d03a0508090258942f536@mail.gmail.com>
Date: Tue, 9 Aug 2005 11:58:19 +0200
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] pci_find_device and pci_find_slot mark as deprecated
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050809041133.GA10552@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42F72D4D.8030102@volny.cz>
	 <200508082354.j78Ns1Cn028468@wscnet.wsc.cz>
	 <20050809041133.GA10552@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/05, Greg KH <greg@kroah.com> wrote:
> On Tue, Aug 09, 2005 at 01:54:01AM +0200, Jiri Slaby wrote:
> > This marks these functions as deprecated not to use in latest drivers (it
> > doesn't use reference counts and the device returned by it can disappear in
> > any time).
> 
> Did you forget to send this to the PCI maintainer for some reason?
No, my badness, sorry.

> Anyway, no, I don't want these functions marked this way, it's only
> going to cause build noise.  I'd much rather you, or others, send me
> patches that remove the usage of these functions so I can just delete
> them entirely.
When the patch was here
(http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4_3.patch --
it'll be certainly sliced into many pieces; of course I didn't cc you
:( ), they told me, that the better way is to let it be, because it
signify the driver as old api based, if there are some warnings, so I
want people to stop using the old functions. So you want me to
continue producing the patches, that removes it?

regards,
jiri
