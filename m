Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbUKSInx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbUKSInx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 03:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbUKSInx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 03:43:53 -0500
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:2450 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S261306AbUKSInv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 03:43:51 -0500
Date: Fri, 19 Nov 2004 11:43:50 +0300
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <willy@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2
Message-ID: <20041119084350.GA14924@tentacle.sectorb.msk.ru>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041118172606.GA6729@tentacle.sectorb.msk.ru> <Pine.LNX.4.58.0411180956290.2222@ppc970.osdl.org> <20041118180100.GR26623@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20041118180100.GR26623@parcelfarce.linux.theplanet.co.uk>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.6.9-rc2-mm1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 06:01:00PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 18, 2004 at 09:59:00AM -0800, Linus Torvalds wrote:
> > Nope. It got fixed differently: by only adding POSIX locks to the list. 
> > See locks_insert_block(). Since a non-posix lock cannot be blocked by a 
> > POSIX lock, the "if (IS_POSIX(blocker))" test should make sure we're 
> > always proper.
> > 
> > At least that's Willy claims. If you think he's wrong, holler.
> > 
> > Willy Cc'd, once more.
> 
> The problem certainly should have been fixed.  I'd like to know if it
> still occurs.
> 

It does not, thank you.

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

