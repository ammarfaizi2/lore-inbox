Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269603AbUHZU7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269603AbUHZU7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269635AbUHZUyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:54:33 -0400
Received: from mail.shareable.org ([81.29.64.88]:9927 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S269637AbUHZUuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:50:39 -0400
Date: Thu, 26 Aug 2004 21:48:41 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826204841.GC5733@mail.shareable.org>
References: <Pine.LNX.4.58.0408261217140.2304@ppc970.osdl.org> <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> For objects that do both, how does the user choose ?
> 
> Do we really want to have a file paradigm that's different
> from the other OSes out there ?

What does MacOS X do?  Someone said that documents are directories in
it; it must know how to handle that.

What does Windows do when you click on a .zip file and WinZIP is
installed?  It opens the .zip file and lets you explore inside.  When
you click on a .doc file, though, it opens a viewer or editor -- you
don't get the option to look inside.

> What happens when users want to transfer data from Linux
> to another system ?

This is why I favour storing all essential metadata (about the file's
content) inside the file's contents, the primary stream.

We have another problem: what happens when users want to transfer data
from Windows (with secondary streams) and MacOS (with resource forks)?

-- Jamie
