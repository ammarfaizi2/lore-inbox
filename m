Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUBTA0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267704AbUBTAXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:23:50 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:56252 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S267703AbUBTAVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:21:51 -0500
Date: Thu, 19 Feb 2004 16:21:41 -0800
From: Tim Hockin <thockin@sun.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jeff Sipek <jeffpc@optonline.net>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: sysconf - exposing constants to userspace
Message-ID: <20040220002140.GG9155@sun.com>
Reply-To: thockin@sun.com
References: <20040219204820.GC9155@sun.com> <200402191630.47047.jeffpc@optonline.net> <20040220002034.GC5590@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220002034.GC5590@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 12:20:34AM +0000, Jamie Lokier wrote:
> Jeff Sipek wrote:
> > I think that making something in /sys would make the most sense,
> > with one constant per file. We could dump the consts files to for
> > example /sys/consts, or make a logical directory structure to make
> > navigation easier.
> 
> Isn't that very similar to the /proc/sys/kernel we have now?

sysctls are all writable (unless I am missing something).  A lot of these
things are not really tunables.

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
