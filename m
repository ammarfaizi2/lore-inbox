Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132574AbRDKPOa>; Wed, 11 Apr 2001 11:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbRDKPOU>; Wed, 11 Apr 2001 11:14:20 -0400
Received: from t2.redhat.com ([199.183.24.243]:1532 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S132574AbRDKPOF>; Wed, 11 Apr 2001 11:14:05 -0400
Date: Wed, 11 Apr 2001 16:14:04 +0100 (BST)
From: Bernd Schmidt <bernds@redhat.com>
To: Andreas Franck <afranck@gmx.de>
Cc: David Howells <dhowells@cambridge.redhat.com>, <torvalds@transmeta.com>,
        <andrewm@uow.edu.au>, <bcrl@redhat.com>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2nd try: i386 rw_semaphores fix
In-Reply-To: <24940.987001245@www17.gmx.net>
Message-ID: <Pine.LNX.4.30.0104111606010.1106-100000@host140.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001, Andreas Franck wrote:

> Hello David,
>
> > I've been discussing it with some other kernel and GCC people, and they
> > think
> > that only "memory" is required.
>
> Hmm.. I just looked at my GCC problem report from December, perhaps you're
> interested, too:
>
> http://gcc.gnu.org/ml/gcc-bugs/2000-12/msg00554.html
>
> The example in there compiles out-of-the box and is much easier to
> experiment on than the whole kernel :-)

That example seems to fail because a "memory" clobber only tells the compiler
that memory is written, not that it is read.


Bernd

