Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270383AbTHBWOU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 18:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270385AbTHBWOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 18:14:20 -0400
Received: from almesberger.net ([63.105.73.239]:54541 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S270383AbTHBWOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 18:14:19 -0400
Date: Sat, 2 Aug 2003 19:14:11 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
Message-ID: <20030802191411.H5798@almesberger.net>
References: <20030802140444.E5798@almesberger.net> <1059857864.20305.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059857864.20305.14.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Aug 02, 2003 at 09:57:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> It moves the cost it doesnt make it vanish

I don't think it really can. What it can do is reduce the
overhead (which usually translates to latency and burstiness)
and the sharing.

> If I read you right you are arguing for a second processor running
> Linux.with its own independant memory bus. AMD make those already its
> called AMD64. I don't know anyone thinking at that level about
> partitioning one as an I/O processor.

That's taking this idea to an extreme, yes. I'd think of
using something as big as an amd64 for this as "too
expensive", but perhaps it's cheap enough in the long run,
compared to some "optimized" design.

It would certainly have the advantage of already solving
various consistency and compatibility issues. (That is, if
your host CPUs is/are also amd64.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
