Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUIBHP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUIBHP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUIBHPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:15:15 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:10150 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267607AbUIBHPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:15:10 -0400
Message-ID: <4136C876.5010806@namesys.com>
Date: Thu, 02 Sep 2004 00:15:02 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>. Doing transactions on one file is 
>only the beginning - you'll find people who want transactions across file 
>boundaries etc.
>  
>
Yup, that's what reiser4 is aiming at and where things get exciting for 
version control systems and the like.  We are just missing the api code 
for it at the moment, all the infrastructure is there, and the api is in 
progress in sys_reiser4.

