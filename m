Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315170AbSE2Lz0>; Wed, 29 May 2002 07:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315171AbSE2LzZ>; Wed, 29 May 2002 07:55:25 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:39176 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315170AbSE2LzY>; Wed, 29 May 2002 07:55:24 -0400
Date: Wed, 29 May 2002 13:55:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Woodhouse <dwmw2@infradead.org>, Benjamin LaHaise <bcrl@redhat.com>,
        jw schultz <jw@pegasys.ws>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait queue process state
In-Reply-To: <1022676201.9255.160.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0205291351120.17583-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29 May 2002, Alan Cox wrote:

> > What I'd _really_ like at the moment is an option to allow read_inode() to
> > be interruptible. Currently there's no way for it to exit without leaving a
> > bad inode behind, which prevents the _next_ iget() for that inode from
> > actually succeeding.
> 
> If I remember rightly stat() is not interruptible anyway.

It's possible to automatically restart stat(), so the process would be at
least killable.

bye, Roman

