Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269281AbUHZR72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269281AbUHZR72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269284AbUHZR71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:59:27 -0400
Received: from dp.samba.org ([66.70.73.150]:3514 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269281AbUHZRc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:32:29 -0400
Date: Thu, 26 Aug 2004 10:32:27 -0700
From: Jeremy Allison <jra@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Spam <spam@tnonline.net>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826173227.GB1570@legion.cup.hp.com>
Reply-To: Jeremy Allison <jra@samba.org>
References: <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826024956.08b66b46.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:49:56AM -0700, Andrew Morton wrote:
> Spam <spam@tnonline.net> wrote:
> >
> >    Yes,  for  example  documents,  image  files  etc. The multiple data
> >    streams  can  contain thumbnails, info about who is editing the file
> >    (useful for networked files) etc. Could be used for version handling
> >    and much more.
> 
> All of which can be handled in userspace library code.
> 
> What compelling reason is there for doing this in the kernel?

Because without kernel support there is no way someone can
publish a new metadata type and have it automatically supported
by all application data files (ie. most apps ignore it, and only
apps that are aware of it can see it). Without kernel support
you have to have all apps agree on a data format. And
that's harder to do than getting linux kernel VFS engineers
to agree on things :-).

Jeremy.
