Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261949AbTCHAh7>; Fri, 7 Mar 2003 19:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261951AbTCHAh7>; Fri, 7 Mar 2003 19:37:59 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:65191 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S261949AbTCHAh4>; Fri, 7 Mar 2003 19:37:56 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 7 Mar 2003 16:46:55 -0800 (PST)
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <Pine.LNX.4.44.0303080116500.32518-100000@serv>
Message-ID: <Pine.LNX.4.44.0303071642420.1933-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reason he gave back when the discussion was first started (months ago)
was that klibc is designed to be directly linked into programs, and it was
felt that this would not be possible with the GPL. In fact klibc was
adopted instead of dietlibc speceificly BECOUSE of the license.

while you could add an additional clause to the GPL to allow it to be
linked into programs directly the I seriously doubt if the self appointed
'GPL police' would notice the issue and would expect that fears on the
subject would limit it's use.

David Lang

On Sat, 8 Mar 2003, Roman Zippel wrote:

> Date: Sat, 8 Mar 2003 01:38:12 +0100 (CET)
> From: Roman Zippel <zippel@linux-m68k.org>
> To: H. Peter Anvin <hpa@zytor.com>
> Cc: Russell King <rmk@arm.linux.org.uk>,
>      Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
>      linux-kernel@vger.kernel.org
> Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
>
> Hi,
>
> On Fri, 7 Mar 2003, H. Peter Anvin wrote:
>
> > Right, of course.  However, the first step (which Greg has accomplished)
> > is to get klibc merged into the kernel build.  We already have ipconfig
> > and mount-nfs binaries which compile against klibc; now we need to
> > integrate them so they can pick up the ip= and nfsroot= options and do
> > the right thing in userspace.
>
> But before it's actually merged, I would slowly really like to know the
> reasoning for license. You completely avoid that question and that makes
> me nervous. Why did you choose this license over any GPL variant?
> We could as well integrate dietlibc and if anyone has a problem with it,
> he can still choose your klibc.
> Why should I contribute to klibc instead of dietlibc?
>
> bye, Roman
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
