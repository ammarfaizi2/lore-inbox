Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTLJXtc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTLJXtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:49:32 -0500
Received: from gaia.cela.pl ([213.134.162.11]:60421 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264252AbTLJXtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:49:31 -0500
Date: Thu, 11 Dec 2003 00:48:35 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: Witukind <witukind@nsbm.kicks-ass.org>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       <linux-kernel@vger.kernel.org>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
In-Reply-To: <3FD78645.9090300@wmich.edu>
Message-ID: <Pine.LNX.4.44.0312110046350.3331-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not saying module use is more memory efficient than not or vice 
> versa, but if memory usage in the 100K range is going to be the only 
> argument for autoloading/unloading of modules then it's really _not_ 
> worth the effort unless someone can give that kind of support without 
> trying.  Your fight for memory efficiency should start where the 
> inefficiency is the largest, and work it's way down, not the other way 
> around.

That's not quite true - all kernel memory is statically mapped into ram 
and unswappable.  2 MB's of X will likely end up 80% swapped to disk and 
the rest is in use (and can still be swapped out when no longer needed). 
100KB of an unused driver will not get swapped out.  
That's where the difference is.  As for using small userspace?  I do, 
djbdns for dns, twm for window manager etc etc...

Cheers,
MaZe.


