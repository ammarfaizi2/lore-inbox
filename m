Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266777AbUHZBHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266777AbUHZBHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 21:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUHZBFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 21:05:25 -0400
Received: from mail.shareable.org ([81.29.64.88]:40645 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266613AbUHZBEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 21:04:47 -0400
Date: Thu, 26 Aug 2004 02:03:55 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nicholas Miell <nmiell@gmail.com>
Cc: Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826010355.GB24731@mail.shareable.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093480940.2748.35.camel@entropy>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:
> Anything that currently stores a file's metadata in another file really
> wants this right now. Things like image thumbnails, document summaries,
> digital signatures, etc.

Additionally, all of those things you describe should be deleted if
the file is modified -- to indicate that they're no longer valid and
should be regenerated if needed.

Whereas there are some other kinds of metadata which should not be
deleted if the file is modified.

-- Jamie
