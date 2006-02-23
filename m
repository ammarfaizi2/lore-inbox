Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWBWSVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWBWSVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWBWSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:21:13 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:62471 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751121AbWBWSVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:21:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=lJ/x6z1k6+eHt1O7+zDZVziYheQhpGpVOdDn7sXxhzKKRw95GpZpAvqYkMPP7/iA0+InV6eBQqg2q75M7YCuf4/KVnL4acN0Fz4EpUVzRObCVEHMR0ToQqDgZF+5EAoBfZ4L6/A0GU+JC7nRMBc/Puj5W8kKmTs/+6BRjwoQ8yA=
Date: Thu, 23 Feb 2006 21:21:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: zcat: stdin: decompression OK (was: Re: 2.6.16-rc4-mm1)
Message-ID: <20060223182107.GB7803@mipter.zuzino.mipt.ru>
References: <20060220042615.5af1bddc.akpm@osdl.org> <43FC6B8F.4060601@ums.usu.ru> <20060222225325.10a71472.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222225325.10a71472.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 10:53:25PM -0800, Randy.Dunlap wrote:
> On Wed, 22 Feb 2006 18:47:59 +0500 Alexander E. Patrakov wrote:
> > Unfortunately, I lost my .config from the old kernel, so I attempted the
> > following:
> >
> > cd scripts
> > make binoffset
> > cd ..
> > scripts/extract-ikconfig /boot/vmlinuz-2.6.16-rc3-mm1-home >.config
> >
> > This results in:
> >
> > zcat: stdin: decompression OK, trailing garbage ignored
>
> No other output?  what $ARCH?
> What did the .config file contain?  was it correct?
> so is the only problem the zcat warning message?
>
> I tested extract-ikconfig several times without errors (on 2.6.16-rc4-mm1).

Since I can reproduce it, Randy, what version do you use? 1.3.5-r8 here
from Gentoo.

At least, we can trivially shut it up.

