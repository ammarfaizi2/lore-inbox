Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTJGRz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 13:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbTJGRz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 13:55:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:39915 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262547AbTJGRz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 13:55:56 -0400
Date: Tue, 7 Oct 2003 10:55:47 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs. udev
Message-ID: <20031007175547.GE1956@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de> <yw1xekxpdtuq.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xekxpdtuq.fsf@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 04:07:25PM +0200, Måns Rullgård wrote:
> 
> I'd also like an explanation of the rationale behind the switch.
> devfs works and is stable.  Why replace it with an incomplete fragile
> userspace solution?  I recall reading something about the original
> author not updating devfs recently, but I can't see why that requires
> rewriting it from scratch.

There's no "rewriting from scratch" happening here.  Although
Christoph's devfs changes in the 2.6 kernel tree were a major
improvement on the quality of the devfs interface (within the kernel
code), there are still unfixable devfs bugs in the code.

thanks,

greg k-h
