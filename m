Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269509AbUHZVp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269509AbUHZVp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269677AbUHZVoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:44:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:62911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269509AbUHZVjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:39:04 -0400
Date: Thu, 26 Aug 2004 14:31:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: David Lang <david.lang@digitalinsight.com>,
       Christophe Saout <christophe@saout.de>, Rik van Riel <riel@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826211918.GF5733@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0408261422370.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
 <1093536282.5482.6.camel@leto.cs.pocnet.net> <Pine.LNX.4.60.0408261348370.27825@dlang.diginsite.com>
 <20040826211918.GF5733@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Jamie Lokier wrote:
> 
> With good cacheing, I could cd into the .tar.bz2 files and
> _effectively_ have the performance of untarred source trees for the
> ones I look at often on my disk -- automatically cleaned if the space
> if needed for something else, too.  It would be quite nice.

What you're talking about is just a caching filesystem. Then you can have 
any deamon do whatever it wants to fill it - whether from tar-files or 
over the network or anything else.

I think you should ask David Howells about it..

		Linus
