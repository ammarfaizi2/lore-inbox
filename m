Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136541AbREGSVi>; Mon, 7 May 2001 14:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136522AbREGSV2>; Mon, 7 May 2001 14:21:28 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:65032 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S136520AbREGSVO>; Mon, 7 May 2001 14:21:14 -0400
Date: Mon, 7 May 2001 11:21:13 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <alexander.eichhorn@rz.tu-ilmenau.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Explanation of zero-copy networking
In-Reply-To: <E14wlUi-0003WQ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105071106470.10009-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, Alan Cox wrote:

> > documented so far) detailed description of the newly
> > implemented zero-copy mechanisms in the network-stack.
> > We are interested in how to use it (changed network-API?)
> > and also in the internal architecture.
>
> It is built around sendfile. Trying to do zero copy on pages with user space
> mappings get so horribly non pretty it is better to build the API from the
> physical side of things.

so there's still single copy for write() of a mmap()ed page?

since i'm naive about the high-end databases -- do they have a mechanism
to access zero-copy?  i suppose sendfile() on a raw device fd would
work... nice.

-dean

