Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135268AbREFJQo>; Sun, 6 May 2001 05:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135281AbREFJQe>; Sun, 6 May 2001 05:16:34 -0400
Received: from [24.70.141.118] ([24.70.141.118]:27129 "EHLO asdf.capslock.lan")
	by vger.kernel.org with ESMTP id <S135268AbREFJQW>;
	Sun, 6 May 2001 05:16:22 -0400
Date: Sun, 6 May 2001 05:16:14 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4 add suffix for uname -r 
In-Reply-To: <3437.989135106@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.33.0105060511410.1549-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2001, Keith Owens wrote:

>>On Sun, 6 May 2001, Keith Owens wrote:
>>>A frequent requirement is to rename vmlinuz-2.x.y to 2.x.y-old or
>>>2.x.y.save to preserve a working kernel.
>>
>>I don't see how this patch is necessary when we have
>>"EXTRAVERSION" available.  Change EXTRAVERSION in your kernel
>>builds and it is totally a non issue.  No renaming of anything is
>>necessary.
>
>You already have a working kernel which you want to rename to use as a
>backup version.

Why?  Just use it as a backup version.  No need to rename
anything at all.  I never rename a kernel, Sysmap, module dir or
anything when trying out a new kernel.   I use EXTRAVERSION
instead - for its intended purpose - which was to eliminate these
sort of problems.

>Changing EXTRAVERSION and recompiling builds a new kernel and
>adds uncertainty about whether the kernel still works - did you
>change anything else before recompiling?

How could it possibly add any uncertainity about anything?  My
kernel is 2.4.2-2 right now.  If I build a new one, it will be
2.4.4-1asdf probably (asdf is my machine).  If I then want to try
a new kernel but am not sure if I want the old one still, the new
kernel will be 2.4.4-2asdf.  None of the kernels have files that
conflict, and the names of them never change.  I add a new stanza
to lilo for the new kernel, run lilo, and can easily boot any of
the kernels.

>Look at all the install scripts that rename vmlinuz to
>vmlinuz-old.

Better yet, rewrite those broken scripts to work with todays
kernel features.  My install-kernel script works just fine for
adding a new kernel to the system.

By using new tools you avoid old problems.


------------------------------------------------------------------------
Signature poll:  I'm planning on getting a 12 or 16 port autosensing
10/100 ethernet switch soon for home use, and am interested in hearing
others recommendations on what to buy.  Cost isn't as important as is
functionality and quality.  Any suggestions appreciated.
------------------------------------------------------------------------

