Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUIBH4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUIBH4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUIBH4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:56:36 -0400
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:18 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S267798AbUIBH4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:56:03 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
Date: Thu, 2 Sep 2004 09:55:57 +0200
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <20040826150202.GE5733@mail.shareable.org> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com>
In-Reply-To: <4136C876.5010806@namesys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409020955.57286.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 September 2004 09.15, Hans Reiser wrote:
> Linus Torvalds wrote:
> >. Doing transactions on one file is
> >only the beginning - you'll find people who want transactions across file
> >boundaries etc.
>
> Yup, that's what reiser4 is aiming at and where things get exciting for
> version control systems and the like.  We are just missing the api code
> for it at the moment, all the infrastructure is there, and the api is in
> progress in sys_reiser4.

Hope that is the same as or implied XA-support. Having to syncrhonized file 
updates with database transactions is not an uncommon problem. 

-- robin
