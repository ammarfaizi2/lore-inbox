Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268172AbUIBKc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268172AbUIBKc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUIBKcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:32:04 -0400
Received: from ppp1-adsl-145.the.forthnet.gr ([193.92.232.145]:31529 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S268147AbUIBKbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:31:51 -0400
From: V13 <v13@priest.com>
To: Spam <spam@tnonline.net>
Subject: Re: The argument for fs assistance in handling archives
Date: Thu, 2 Sep 2004 13:27:20 +0300
User-Agent: KMail/1.7
Cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <20040826150202.GE5733@mail.shareable.org> <4136E0B6.4000705@namesys.com> <1117111836.20040902115249@tnonline.net>
In-Reply-To: <1117111836.20040902115249@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409021327.22998.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 September 2004 12:52, Spam wrote:
> > Linus Torvalds wrote:
> > Besides, there are enhancements which are simply compelling.  You can
> > write a dramatically better performance version control system with a
> > much simpler design if the FS is atomic.    Our transaction manager
> > first draft was written by a version control guy, and he would probably
> > be happy to tell you how  lack of atomicity other than rename makes
> > version control software design hideous.
>
>   Btw, version control for ordinary files would be a great feature. I
>   think something like it is available through Windows 2000/3 server.
>   Isn't it called "Shadow Copies". It works over network shares. :)
>
>   It allows you to restore previous versions of the file even if you
>   delete or overwrite it.
>
>   Features like this do make a good point and helps protecting data -
>   something that is important IMHO.

I believe you mean something simillar to: 

file1.txt;1
file1.txt;2
file1.txt;3 (yeap, it's VMS) 

where you'll have to cleanup old versions when you don't need them any more... 
AFAIK that this is older than HDDs

<<V13>>
