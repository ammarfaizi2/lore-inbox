Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269651AbRHCWrD>; Fri, 3 Aug 2001 18:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269653AbRHCWqz>; Fri, 3 Aug 2001 18:46:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10381 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269651AbRHCWqg>;
	Fri, 3 Aug 2001 18:46:36 -0400
Date: Fri, 3 Aug 2001 18:45:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic
 change patch)
In-Reply-To: <20010804100143.A17774@weta.f00f.org>
Message-ID: <Pine.GSO.4.21.0108031840090.5264-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Chris Wedgwood wrote:

> Linus, one more thing --- the first argument to ->fsync is struct file*
> and nothing uses it, I'd like to blow it away or would you prefer we

nfs_fsync().

