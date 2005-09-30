Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbVI3TbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbVI3TbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 15:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVI3TbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 15:31:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:6893 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030373AbVI3TbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 15:31:14 -0400
Date: Fri, 30 Sep 2005 20:31:13 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cross-toolchain (Gentoo)
Message-ID: <20050930193113.GN7992@ftp.linux.org.uk>
References: <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20050930125645.GJ7992@ftp.linux.org.uk> <20050930160911.GA24810@mipter.zuzino.mipt.ru> <20050930160503.GK7992@ftp.linux.org.uk> <20050930175550.GA24071@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930175550.GA24071@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 09:55:50PM +0400, Alexey Dobriyan wrote:
> On Fri, Sep 30, 2005 at 05:05:03PM +0100, Al Viro wrote:
> > On Fri, Sep 30, 2005 at 08:09:11PM +0400, Alexey Dobriyan wrote:
> > > 1) Watch for it to install gcc 3.4.*. Chances of successful build are much
> > >    higher than with 3.3. Use --g switch of crossdev (_especially_ with
> > >    s390).
> > 
> > Umm...  Is crossdev toolchain with target==host the same as native one?
> 
> Not sure what do you mean... Native gcc here is 3.3.6.
> 
> 	# crossdev -p -v -s1 -t i686-unknown-linux-gnu
> 
> will install binutils-2.16.1 and gcc-3.4.4.

... then we have a problem.  The point is to get build coverage equivalent
to native builds.  Cross-toolchain out of sync with native one means PITA
in that respect.
