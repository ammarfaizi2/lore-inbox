Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267359AbSKPVCA>; Sat, 16 Nov 2002 16:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267360AbSKPVCA>; Sat, 16 Nov 2002 16:02:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267359AbSKPVB7>;
	Sat, 16 Nov 2002 16:01:59 -0500
Message-ID: <3DD6B3C1.70900@pobox.com>
Date: Sat, 16 Nov 2002 16:08:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Thierry Vignaud <tvignaud@mandrakesoft.com>,
       Rusty Russell <rusty@rustcorp.com.au>, kaos@ocs.com.au,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: Modules in 2.5.47-bk...
References: <20021114042738.2091E2C080@lists.samba.org> <m2bs4si29f.fsf@vador.mandrakesoft.com> <20021116135030.GE10408@fs.tum.de>
In-Reply-To: <20021114042738.2091E2C080@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> On Thu, Nov 14, 2002 at 04:45:16PM +0100, Thierry Vignaud wrote:
>
> >Rusty Russell  writes:
> >
> >
> >>>The backward compat thing is really a hack, and not system
> >>>software done right :( modutils should not need to rename all its
> >>>binaries *.old -- and have that be the default that users see when
> >>>installing the rpm.  No company worth its shareholders would
> >>>release a package full of "*.old" binaries.  Come on...
> >>
> >>OK, would calling it "*-2.4" or something help?
> >
> >most distros come with some alternative system (at lest, debian, mdk &
> >rh), so this problem can legally be left to vendors.
>
>
> The alternative system doesn't work in this case because it doesn't help
> you when you want to switch between 2.4 and 2.6 kernels. You need some
> kind of wrapper.



Agreed.  The alternatives stuff I am familiar with does not changes 
symlinks based on the version of booted kernel, AFAIK.

	Jeff



