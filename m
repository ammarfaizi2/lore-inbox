Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265125AbSJaChU>; Wed, 30 Oct 2002 21:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbSJaChU>; Wed, 30 Oct 2002 21:37:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37514 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265125AbSJaChT>;
	Wed, 30 Oct 2002 21:37:19 -0500
Date: Wed, 30 Oct 2002 21:43:29 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210302135150.13031-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Oct 2002, Linus Torvalds wrote:

> > ext2/ext3 ACLs and Extended Attributes
> 
> I don't know why people still want ACL's. There were noises about them for 
> samba, but I'v enot heard anything since. Are vendors using this?

Because People Are Stupid(tm).  Because it's cheaper to put "ACL support: yes"
in the feature list under "Security" than to make sure than userland can cope
with anything more complex than  "Me Og.  Og see directory.  Directory Og's.
Nobody change it".  C.f. snake oil, P.T.Barnum and esp. LSM users

