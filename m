Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUHZKCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUHZKCv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUHZKBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:01:51 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:32909 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268070AbUHZJ5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:57:16 -0400
Date: Thu, 26 Aug 2004 11:59:59 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1565398922.20040826115959@tnonline.net>
To: Matt Mackall <mpm@selenic.com>
CC: Nicholas Miell <nmiell@gmail.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       <torvalds@osdl.org>, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826053200.GU31237@waste.org>
References: <20040825152805.45a1ce64.akpm@osdl.org>
 <112698263.20040826005146@tnonline.net>
 <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
 <1453698131.20040826011935@tnonline.net>
 <20040825163225.4441cfdd.akpm@osdl.org>
 <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net>
 <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org>
 <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> cp, grep, cat, and tar will continue to work just fine on files with
>> multiple streams.

> Find some silly person with an iBook and open a shell on OS X. Use cp
> to copy a file with a resource fork. Oh look, the Finder has no idea
> what the new file is, even though it looks exactly identical in the
> shell. Isn't that _wonderful_? Now try cat < a > b on a file with a
> fork. How is that ever going to work?

  It  should  work  on  the main file, the extra streams and meta data
  won't be copied.  Just as it is now with special attributes etc. Cat
  reads the content of a file stream, not the file container.

> I like cat < a > b. You can keep your progress.





