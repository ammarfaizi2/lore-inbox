Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbRGMKXx>; Fri, 13 Jul 2001 06:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbRGMKXn>; Fri, 13 Jul 2001 06:23:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:25810 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266994AbRGMKX1>;
	Fri, 13 Jul 2001 06:23:27 -0400
Date: Fri, 13 Jul 2001 06:23:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: malfet@gw.mipt.sw.ru
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: Question about ext2
In-Reply-To: <20010713135759.A9986@srv.mipt.sw.ru>
Message-ID: <Pine.GSO.4.21.0107130619270.17323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Jul 2001 malfet@gw.mipt.sw.ru wrote:

> I don't find this check in chain started from syscall and ends in ext2_rename
> Correct me if I'm wrong.

Take a look at may_delete(). Heck, it's even documented there -
 *  7. If we were asked to remove a directory and victim isn't one - ENOTDIR.
 *  8. If we were asked to remove a non-directory and victim isn't one - EISDIR.

