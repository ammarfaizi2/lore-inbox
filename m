Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270273AbTGSQCj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270403AbTGSQCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 12:02:38 -0400
Received: from adedition.com ([216.209.85.42]:51208 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S270273AbTGSQCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 12:02:37 -0400
Date: Sat, 19 Jul 2003 12:17:25 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: John Bradford <john@grabjohn.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: Bitkeeper
Message-ID: <20030719161725.GD17587@mark.mielke.cc>
References: <200307191600.h6JG0OZd002669@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307191600.h6JG0OZd002669@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 05:00:24PM +0100, John Bradford wrote:
> > Any investment into writing a new source management
> > system would be better served by improving the linux source code.
> What happens if somebody develops a really good versioned filesystem
> for Linux, would it not get merged, because the linux kernel would
> then contain SCM-like functionality?

One day, when it happens, we'll see what ripple effects it has.

In most cases, however, I suspect that a versioned file system will never
be a replacement for a good source management system. The lines could become
blurred, but the 'good versioned file system' might take the form a kernel
module that allowed SCM systems to plug into it, at which point, Bit Keeper
might plug into it, and everybody would be happy. I doubt you want to put
merge manager functionality into the kernel, or many of the other components
of a good source management system. The storage and access is one of the
lesser concerns. Bit Keeper uses similar storage and access methods as
SCCS, does it not?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

