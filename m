Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268729AbUHZLeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268729AbUHZLeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268783AbUHZL2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:28:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:18850 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268633AbUHZLW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:22:58 -0400
Date: Thu, 26 Aug 2004 04:20:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Spam <spam@tnonline.net>
Cc: wichert@wiggy.net, jra@samba.org, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040826042043.15978b0a.akpm@osdl.org>
In-Reply-To: <1453776111.20040826131547@tnonline.net>
References: <20040824202521.GA26705@lst.de>
	<412CEE38.1080707@namesys.com>
	<20040825152805.45a1ce64.akpm@osdl.org>
	<112698263.20040826005146@tnonline.net>
	<Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
	<1453698131.20040826011935@tnonline.net>
	<20040825163225.4441cfdd.akpm@osdl.org>
	<20040825233739.GP10907@legion.cup.hp.com>
	<20040825234629.GF2612@wiggy.net>
	<1939276887.20040826114028@tnonline.net>
	<20040826024956.08b66b46.akpm@osdl.org>
	<839984491.20040826122025@tnonline.net>
	<20040826032457.21377e94.akpm@osdl.org>
	<742303812.20040826125114@tnonline.net>
	<20040826035500.00b5df56.akpm@osdl.org>
	<1453776111.20040826131547@tnonline.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> wrote:
>
>    Secondly, do you expect file managers like Nautilus and Konqueror to
>    support  every piece of file format on the planet so they could read
>    information directly from the documents?

Sure.  You're proposing that we implement a single, golden multi-stream file
format in the kernel.

We could just as well do that in libmultistreamfileformat.so.

But I'll grant that one cannot go adding new metadata to, say, C files this
way.  I don't know how useful such a thing is though.

Remember that my main point is that there's a lack of coordination in
userspace.  Hell, there's none.  Putting it in-kernel forces that
coordination, and may be the way to go, but it's pretty sad.

