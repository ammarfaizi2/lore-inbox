Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279103AbRKSPEn>; Mon, 19 Nov 2001 10:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279064AbRKSPEY>; Mon, 19 Nov 2001 10:04:24 -0500
Received: from [195.66.192.167] ([195.66.192.167]:64007 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S278985AbRKSPEM>; Mon, 19 Nov 2001 10:04:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 17:03:40 +0000
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111190927100.17210-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0111190927100.17210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01111917034005.00817@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 14:46, Alexander Viro wrote:
> On Mon, 19 Nov 2001, vda wrote:
> > Everytime I do 'chmod -R a+rX dir' and wonder are there
> > any executables which I don't want to become world executable,
> > I think "Whatta hell with this x bit meaning 'can browse'
> > for dirs?! Who was that clever guy who invented that? Grrrr"
> >
> > Isn't r sufficient? Can we deprecate x for dirs?
> > I.e. make it a mirror of r: you set r, you see x set,
> > you clear r, you see x cleared, set/clear x = nop?
>
> See UNIX FAQ.  Ability to read != ability to lookup.
>
> Trivial example: you have a directory with a bunch of subdirectories.
> You want owners of subdirectories to see them.  You don't want them
> to _know_ about other subdirectories.

Security through obscurity, that is.

Do you have even a single dir on your boxes with r!=x?
--
vda
