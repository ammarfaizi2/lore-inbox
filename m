Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266218AbSKZGwv>; Tue, 26 Nov 2002 01:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbSKZGwv>; Tue, 26 Nov 2002 01:52:51 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:44815 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S266218AbSKZGwu>; Tue, 26 Nov 2002 01:52:50 -0500
Date: Tue, 26 Nov 2002 02:02:50 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Andi Kleen <ak@suse.de>
cc: Jeff Dike <jdike@karaya.com>, <linux-kernel@vger.kernel.org>
Subject: Re: uml-patch-2.5.49-1
In-Reply-To: <20021126061021.GA17959@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0211260159440.7540-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Andi Kleen wrote:

> > One reason I can think of is that it prevents 'stupid things' happening
> > under a copy of UML from killing the OS UML is running under... Eg. if a
> > process is running under UML because it's not trusted and then turns into
> > a forkbomb, you don't want that taking down the host OS.
>
> You could limit that with an appropiate ulimit.
>
> Also a 'mm-bomb' could be similarly deadly without appropiate host limits.

That's just one example... the idea is that you want maximal separation
between the guest OS's apps and the host OS.  Sort of like "VM" on IBM's
series of mainframe architecures.  Of course, that's virtualization done
in hardware not in software, but the principles are the same; you want a
maximal amount of separation between the layers.

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu


