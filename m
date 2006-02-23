Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWBWP1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWBWP1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWBWP1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:27:42 -0500
Received: from xenotime.net ([66.160.160.81]:28344 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751336AbWBWP1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:27:41 -0500
Date: Thu, 23 Feb 2006 07:27:41 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
In-Reply-To: <43FD7C49.10302@ums.usu.ru>
Message-ID: <Pine.LNX.4.58.0602230727050.18778@shark.he.net>
References: <20060220042615.5af1bddc.akpm@osdl.org> <43FC6B8F.4060601@ums.usu.ru>
 <20060222225325.10a71472.rdunlap@xenotime.net> <43FD7C49.10302@ums.usu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Alexander E. Patrakov wrote:

> Randy.Dunlap wrote:
> > On Wed, 22 Feb 2006 18:47:59 +0500 Alexander E. Patrakov wrote:
> >> zcat: stdin: decompression OK, trailing garbage ignored
> >
> > No other output?  what $ARCH?
>
> No other output, the arch is i386, userspace is Debian Sarge.
>
> > What did the .config file contain?  was it correct?
>
> The end result was correct. The problematic kernel image (with the
> config in it) can be accessed at:
>
> http://ums.usu.ru/~patrakov/vmlinuz-2.6.16-rc3-mm1-home
>
> (please notify when I can erase it)

I have it, so you can erase it...

> > so is the only problem the zcat warning message?
>
> Yes.
>
> > I tested extract-ikconfig several times without errors (on 2.6.16-rc4-mm1).
>
> I will dig more into the problem today. Reverting extract-ikconfig-*
> patches didn't help.

Thanks.
-- 
~Randy
