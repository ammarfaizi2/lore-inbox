Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUHZLE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUHZLE2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUHZK7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:59:01 -0400
Received: from mail.shareable.org ([81.29.64.88]:59589 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267859AbUHZKxh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:53:37 -0400
Date: Thu, 26 Aug 2004 11:53:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826105330.GB30449@mail.shareable.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <Pine.LNX.4.58.0408260204050.22259@artax.karlin.mff.cuni.cz> <Pine.LNX.4.58.0408251723540.17766@ppc970.osdl.org> <412DA11B.2070303@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412DA11B.2070303@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> being able to cat dirname/pseudos/cat and get a 
> concatenation of all of the files is nice, and being able to cat 
> dirname/pseudos/tar and get an archive of the directory is nice

Yes.  Being able to cd into filename.tar.gz and filename.iso is also
nice, but all of these features should be supported by the VFS
generically, not in any specific filesystem, and there should be a
hook to invoke the various fun filesystem-independent handlers by name.

-- Jamie
