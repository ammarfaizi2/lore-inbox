Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUBAElG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 23:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUBAElG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 23:41:06 -0500
Received: from colo.lackof.org ([198.49.126.79]:54764 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S265210AbUBAElD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 23:41:03 -0500
Date: Sat, 31 Jan 2004 21:41:01 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, Andi Kleen <ak@colin2.muc.de>,
       Andrew Morton <akpm@osdl.org>, mj@ucw.cz,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040201044101.GA3730@colo.lackof.org>
References: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com> <20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk> <20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401290802370.689@home.osdl.org> <20040129164230.GE18725@parcelfarce.linux.theplanet.co.uk> <m1hdybwzli.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hdybwzli.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 02:57:29PM -0700, Eric W. Biederman wrote:
> Is it really safe to treat the base address as a u32?

Sorry...I missed this in the code...but the following confuses me:

>   I know
> if I was doing the BIOS and that address was tied to a 32bit BAR I
> would be extremely tempted to put those 256M of address space above
> 4G.

uhmm, how can one put a 32-bit BAR above 4G?
You meant 64-bit BAR?

> Point being I don't think it is safe to assume the BIOS always puts
> the extended PCI configuration space below 4G.

where MMCONFIG lives is orthogonal to where BARs point to.
I'm pretty sure I missed the point...sorry.

grant
