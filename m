Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTEFSme (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTEFSmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:42:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8576 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S264029AbTEFSmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:42:02 -0400
Date: Tue, 6 May 2003 19:54:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030506185433.GA6023@mail.jlokier.co.uk>
References: <20030506164252.GA5125@mail.jlokier.co.uk> <1052242508.1201.43.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052242508.1201.43.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2003-05-06 at 17:42, Jamie Lokier wrote:
> > So, as dynamic loading is ok between parts of Linux and binary-only
> > code, that seems to imply we could build a totally different kind of
> > binary-only kernel which was able to make use of all the Linux kernel
> > modules.  We could even modularise parts of the kernel which aren't
> > modular now, so that we could take advantage of even more parts of Linux.
> 
> You want a legal list - you really do. Its all about derived works and
> thats an area where even some lawyers will only hunt in packs 8)

Alan, you're right of course - from a legal standpoint.  But I'm not
interested in how it pans out in a strict legal interpretation.

What I'm interested in is how the kernel developers and driver authors
would treat something like that.  Binary modules haven't had the full
lawyer treatment AFAIK, but a sort of community viewpoint regarding
what is and is not acceptable, to the community, is fairly clear on
this list.

So I was wondering what is the community viewpoint when it's the
core kernel that is a non-GPL binary, rather than the modules.

What if this new-fangled other kernel is open source, but BSD license
instead?  Would that also anger the kernel developers?  (As I suspect
a closed-source binary kernel would, even if one could get away with it).

The reason for this question is: These days, if someone wants to
develop a new operating system that is compatible with the full range
of PC hardware, the starting point is to read all the *BSD and Linux
source code that's relevant.  There's no way you can duplicate 12+
years of testing every known PC hardware quirk.  It just isn't feasible.

(And for that reason, I'd regard the drivers as "something that nobody
should be forced to rewrite", to paraphrase what Linus said about klibc).

Then, you can (a) rewrite everything, using the knowledge you gained
from reading the various open source drivers, or (b) just use those
drivers, and save a lot of effort.

-- Jamie


