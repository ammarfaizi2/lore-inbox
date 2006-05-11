Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWEKSZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWEKSZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWEKSZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:25:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22189 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750743AbWEKSZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:25:17 -0400
Date: Thu, 11 May 2006 11:27:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, sfrench@us.ibm.com, stable@kernel.org,
       urban@teststation.com
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
Message-Id: <20060511112718.454094dd.akpm@osdl.org>
In-Reply-To: <9a8748490605111112h8fde257s3de1128ed95577b5@mail.gmail.com>
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net>
	<9a8748490605111112h8fde257s3de1128ed95577b5@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> On 5/11/06, akpm@osdl.org <akpm@osdl.org> wrote:
> >
> > The patch titled
> >
> >      deprecate smbfs in favour of cifs
> >
> > has been added to the -mm tree.  Its filename is
> >
> >      deprecate-smbfs-in-favour-of-cifs.patch
> >
> > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> > out what to do about this
> >
> >
> > From: Andrew Morton <akpm@osdl.org>
> >
> > smbfs is a bit buggy and has no maintainer.  Change it to shout at the user on
> > the first five mount attempts - tell them to switch to CIFS.
> >
> > Come November we'll mark it BROKEN and see what happens.
> >
> [snip]
> 
> Perhaps an addition to  Documentation/feature-removal-schedule.txt  is
> also in order?

That seems a bit duplicative, so I didn't bother.

> Something noting that it will be marked as broken in November and go
> away some 12 - 18 months after that perhaps?

We'll see.  We'd like to remove it as early as poss, of course.  But right
now, I don't know when that'll be.

The personal challenge is to remove it before Greg gets his devfs-removal
patches in ;)

