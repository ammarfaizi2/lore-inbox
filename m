Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUBKDwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 22:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUBKDwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 22:52:55 -0500
Received: from smtp2.dei.uc.pt ([193.137.203.229]:31889 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S263082AbUBKDwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 22:52:53 -0500
Date: Wed, 11 Feb 2004 03:52:43 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Critical problem in 2.6.2 and up
In-Reply-To: <Pine.LNX.4.58.0402110325050.28596@student.dei.uc.pt>
Message-ID: <Pine.LNX.4.58.0402110350240.28596@student.dei.uc.pt>
References: <Pine.LNX.4.58.0402110250580.28596@student.dei.uc.pt>
 <20040210191911.4d6e1308.akpm@osdl.org> <Pine.LNX.4.58.0402110325050.28596@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 11 Feb 2004, Marcos D. Marado Torres wrote:

> On Tue, 10 Feb 2004, Andrew Morton wrote:
>
> > "Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:
> > >
> > > # lilo
> > >
> > >  Warning: '/proc/partitions' does not match '/dev' directory structure.
> > >      Name change: '/dev/nbd0' -> '/tmp/dev.0'
> > >  Warning: '/dev' directory structure is incomplete; device (43, 0) is missing.
> > >  Warning: '/dev' directory structure is incomplete; device (43, 1) is missing.
> > >  Warning: '/dev' directory structure is incomplete; device (43, 2) is missing.
> > >  Warning: '/dev' directory structure is incomplete; device (43, 3) is missing.
> >
> > Please send us your /proc/partitions with, and without that patch.
>
> Follows as attachment.
>
> > If you disable nbd in config, does it help?
>
> I'm going to try it next.

With nbd disabled the patch causes no problems.



- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFAKacOmNlq8m+oD34RAnEpAJ0cY/wWddjHors+eTLq/wXaTOHIkgCghKtX
jFnj+FqWRjVUkj0F9l+DYQY=
=PTyn
-----END PGP SIGNATURE-----

