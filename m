Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUIGSck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUIGSck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268400AbUIGSbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:31:52 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:51963 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268356AbUIGSZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:25:51 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <413DFC06.5070604@namesys.com>
Date: Tue, 07 Sep 2004 11:20:54 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
CC: David Masover <ninja@slaphack.com>,
       Christer Weinigel <christer@weinigel.se>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Tonnerre <tonnerre@thundrix.ch>,
       Spam <spam@tnonline.net>, ReiserFS List <reiserfs-list@namesys.com>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Christoph Hellwig <hch@lst.de>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Chris Wedgwood <cw@f00f.org>
Subject: Re: silent semantic changes with reiser4
References: <200409070206.i8726vrG006493@localhost.localdomain> <413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se> <413DA8EE.nailA301JQ74H@pluto.uni-freiburg.de>
In-Reply-To: <413DA8EE.nailA301JQ74H@pluto.uni-freiburg.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunnar Ritter wrote:

>
>
>You cannot just 'modify cp'. 
>
People who think that POSIX is the objective rather than the least 
common denominator of OS design have had their head screwed on backwards 
to better look at where their competitors used to be.

However, I agree that streams suck.  That is why reiser4 just has files 
and directories and not streams.  Our files and directories just happen 
to be able to do all that streams can do.

Hans
