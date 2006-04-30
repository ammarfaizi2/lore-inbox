Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWD3Rss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWD3Rss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWD3Rss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:48:48 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:61851 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1751212AbWD3Rsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:48:47 -0400
Date: Sun, 30 Apr 2006 13:48:28 -0400
To: Roman Kononov <kononov195-far@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
Message-ID: <20060430174828.GA30582@delft.aura.cs.cmu.edu>
Mail-Followup-To: Roman Kononov <kononov195-far@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <e2ou35$u5r$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ou35$u5r$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 06:00:52PM -0500, Roman Kononov wrote:
> Linus Torvalds wrote:
> > - a lot of the C++ features just won't be supported sanely (ie the kernel 
> >   infrastructure just doesn't do exceptions for C++, nor will it run any 
> >   static constructors etc).
> A lot of C++ features are already supported sanely. You simply need to 
> understand them. Especially templates and type checking. C++ 
> exceptions are not very useful tool in kernels. Static constructor 
> issue is trivial. I use all C++ features (except exceptions) in all 
> projects: Linux kernel modules, embedded real-time applications, 
> everywhere. They _really_ help a lot.

Seriously, your code must be broken.

The C++ standard does not allow an allocator to return NULL, it is
supposed to raise an exception.

Jan

