Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWIIEP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWIIEP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 00:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWIIEP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 00:15:28 -0400
Received: from mail.suse.de ([195.135.220.2]:61387 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932139AbWIIEP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 00:15:28 -0400
Date: Fri, 8 Sep 2006 21:14:45 -0700
From: Greg KH <gregkh@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Adrian Bunk <bunk@stusta.de>
Subject: Re: Fwd: [-stable patch] pci_ids.h: add some VIA IDE identifiers
Message-ID: <20060909041445.GA9254@suse.de>
References: <20060909001925.GB1032@redhat.com> <20060909031020.GA17712@suse.de> <20060909034638.GA16816@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909034638.GA16816@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 11:46:38PM -0400, Dave Jones wrote:
> On Fri, Sep 08, 2006 at 08:10:20PM -0700, Greg KH wrote:
>  > On Fri, Sep 08, 2006 at 08:19:25PM -0400, Dave Jones wrote:
>  > > This never made it into 2.6.17.12
>  > > Without it, this happens..
>  > > 
>  > > drivers/ide/pci/via82cxxx.c:85: error: 'PCI_DEVICE_ID_VIA_8237A' undeclared here (not in a function)
>  > 
>  > Doh!  Sorry about that, I forgot to do a run with 'make allmodconfig'
>  > this time around, and it shows :(
>  > 
>  > .13 will be out shortly...
> 
> Might want to throw this in too, which removes a new warning that appeared in 2.6.17.12
> warning about implicit declaration of idr_remove

That would not have worked, idr_remove wasn't even in the tree :(

I should have fixed it now, thanks.

greg k-h
