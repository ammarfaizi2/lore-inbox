Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280816AbRKTB3H>; Mon, 19 Nov 2001 20:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280750AbRKTB25>; Mon, 19 Nov 2001 20:28:57 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:28569 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280810AbRKTB2m>;
	Mon, 19 Nov 2001 20:28:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Tommi Kyntola <kynde@ts.ray.fi>
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
Date: Mon, 19 Nov 2001 17:28:25 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0111200250560.18953-100000@behemoth.ts.ray.fi>
In-Reply-To: <Pine.LNX.4.33.0111200250560.18953-100000@behemoth.ts.ray.fi>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165zi9-0001AG-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 19, 2001 17:20, you wrote:
> > > I'm using kernel 2.4.15-pre6 and I can see my journal file
> > > on '/'. Should I worry ?
> >
> > No, apparently the .journal file is visible if you created while the
> > filesystem is mounted, but invisible if you create it when the filesystem
> > is unmounted.
>
> Minor corrections though, atleast on my 2.4.15-pre6 with tune2fs 1.23
> the .journal is visible even when created as unmounted.
That's why I said "apparently", I had only heard that the invisible journal 
was only expected to be created on unmounted filesystems, and I hadn't had an 
oppertunity to test it. Thanks for the info.

> And it is not immutable, the only ext2 file attribute set is the "d"
Not on my system:
bodnar42:/home/bodnar42# rm /.journal
rm: remove write-protected file `/.journal'? y
rm: cannot unlink `/.journal': Operation not permit

That's about as immutable as a file can get, and I'm quite sure I did not set 
it immutable manually.

-Ryan
