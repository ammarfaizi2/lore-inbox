Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWEEJ42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWEEJ42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 05:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWEEJ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 05:56:28 -0400
Received: from host-84-9-201-231.bulldogdsl.com ([84.9.201.231]:11510 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1751053AbWEEJ42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 05:56:28 -0400
Date: Fri, 5 May 2006 10:56:04 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Dan Merillat <harik.attar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kbuild + Cross compiling
Message-ID: <20060505095604.GA19892@home.fluff.org>
References: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 09:52:56PM -0400, Dan Merillat wrote:
> I must be an idiot, but why does Kbuild rebuild every file when 
> cross-compiling?
> I'm not editing .config or touching any headers, I'm making tweaks to
> a single .c driver,
> and it is taking forever due to continual full-rebuilds.
> 
> building on i386 for ARCH=arm CROSS_COMPILE=arm-linux-uclibc-
> 
> I tried following the logic, but everything is a forced build using
> if_changed and if_changed_dep, and I can't read GNU Make well enough
> to figure out what it thinks is new.  I know make -d says all the
> dependancies are up-to-date, so it's being forced some other way.

I do not see the problem building ARM kernels using i386
so this is possibly specific to the setup, or something
you are doing, like changing compiler or compiler options.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
