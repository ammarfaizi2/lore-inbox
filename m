Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268273AbUIGPrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268273AbUIGPrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUIGPnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:43:14 -0400
Received: from mx02.qsc.de ([213.148.130.14]:13029 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S268273AbUIGPjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:39:07 -0400
Date: Tue, 07 Sep 2004 17:37:24 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: Spam <spam@tnonline.net>, Christer Weinigel <christer@weinigel.se>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Tonnerre <tonnerre@thundrix.ch>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, Jamie Lokier <jamie@shareable.org>,
       Christoph Hellwig <hch@lst.de>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Chris Wedgwood <cw@f00f.org>
Subject: Re: silent semantic changes with reiser4
Message-ID: <413DD5B4.nailC801GI4E2@pluto.uni-freiburg.de>
References: <200409070206.i8726vrG006493@localhost.localdomain>
 <413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
 <1183150024.20040907143346@tnonline.net>
In-Reply-To: <1183150024.20040907143346@tnonline.net>
User-Agent: nail 11.6pre 9/7/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> wrote:

>   One suggestion is missed. It is to provide system calls for copy.
>   That would also solve the problem.

No, it would not. If you read the POSIX.1 specification for cp
carefully <http://www.unix.org/version3/online.html>, you will
notice that the process for copying a regular file is carefully
standardized. A POSIX.1-conforming cp implementation would not
be allowed to copy additional streams, unless either additional
options are given or the type of the file being copied is other
than S_IFREG. And cp is just one example of a standardized file
handling program.

	Gunnar

-- 
http://omnibus.ruf.uni-freiburg.de/~gritter
