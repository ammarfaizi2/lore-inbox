Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTLJUVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 15:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbTLJUVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 15:21:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43019
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263922AbTLJUVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 15:21:42 -0500
Date: Wed, 10 Dec 2003 12:15:45 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Maciej Zenczykowski <maze@cela.pl>, David Schwartz <davids@webmaster.com>,
       Jason Kingsland <Jason_Kingsland@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.58.0312101115360.29676@home.osdl.org>
Message-ID: <Pine.LNX.4.10.10312101211380.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus:

Okay, can you add to the approved license list "GPL/proprietary" and
"proprietary/GPL" ?

This would allow a legal shim for the hardcare folks to choke down, and
provide the comfort level for others.

Then the trick is when does the license flip modes?
Compile time?
Execution time?

This starts to become more fuzzy than I care to look at right now.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 10 Dec 2003, Linus Torvalds wrote:

> 
> 
> On Wed, 10 Dec 2003, Andre Hedrick wrote:
> >
> > So given RMS and company state OSL and GPL are not compatable, how does
> > the two exist in the current kernel?  Earlier, iirc, there were comments
> > about dual license conflicts.
> 
> They don't "co-exist".
> 
> Some parts of the kernel are dual-licensed, which basically means that the
> author says "you can use this code under _either_ the GPL or the OSL".
> 
> When used in the kernel, the GPL is the one that matters. But being
> dual-licensed means that the same thing may be used somewhere else under
> another license (so you could use that particular instance of code under
> the OSL in some _other_ project where the OSL would be ok).
> 
> This is pretty common. We have several drivers that are dual-GPL/BSD, and
> there are some parts that are dual GPL/proprietary (which is just another
> way of saying that the author is licensing it somewhere else under a
> proprietary model - common for hardware manufacturers that write their
> own driver and _also_ use it somewhere else: when in Linux, they license
> it under the GPL, when somewhere else, they have some other license).
> 
> This isn't Linux-specific - you'll find the same thing in other projects.
> Most well-known perhaps perl - which is dual Artistic/GPL (I think.
> That's from memory).
> 
> And ghostscript was (is?) dual-licensed too (proprietary/GPL).
> 
> 		Linus
> 

