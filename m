Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUBRJ72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 04:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUBRJ71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 04:59:27 -0500
Received: from mail.shareable.org ([81.29.64.88]:28293 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263909AbUBRJ70
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 04:59:26 -0500
Date: Wed, 18 Feb 2004 09:59:15 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
Message-ID: <20040218095915.GC28599@mail.shareable.org>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr> <20040216062152.GB5192@pegasys.ws> <20040216155534.GA17323@mail.shareable.org> <20040217064755.GC9466@pegasys.ws> <20040217213714.GI24311@mail.shareable.org> <Pine.LNX.4.58.0402171400540.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0402171400540.2154@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Doesn't "screen" already do this? I don't think you want to have the
> locale handling in the kernel, along with translation of multi-key
> characters (and from things like CJK terminals? I don't know what format
> they send).  Sounds like you should use a user-mode thing that knows about
> locales...

Yes.  I was thinking in a rather DEC VT100/Putty/xterm- centric way
for a moment; please excuse the slip.

It's irritating that logging in from the wrong kind of terminal
doesn't just provide the right "user experience" for the command line
automatically.  It's also a pain that ssh doesn't inform the remote
end whether the local terminal is UTF-8, so everything seem to be
working fine until one day you discover typing "£" in an editor just
beeps.  Grr..  Oh well.

These are all solvable in userspace.  Then again, so were most of the
other stty options; didn't stop them from being implemented in the kernel :)

-- Jamie
