Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbWHDJVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWHDJVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWHDJVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:21:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751251AbWHDJVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:21:01 -0400
Date: Fri, 4 Aug 2006 02:19:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>, Auke Kok <auke-jan.h.kok@intel.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, davej@redhat.com, chuckw@quantumlinux.com,
       reviews@ml.cw.f00f.org, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/23] -stable review
Message-Id: <20060804021950.3493e85d.akpm@osdl.org>
In-Reply-To: <9a8748490608040204o58f7f594qe8c3316fcdf00ea4@mail.gmail.com>
References: <20060804053807.GA769@kroah.com>
	<9a8748490608040204o58f7f594qe8c3316fcdf00ea4@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 11:04:36 +0200
"Jesper Juhl" <jesper.juhl@gmail.com> wrote:

> On 04/08/06, Greg KH <gregkh@suse.de> wrote:
> > This is the start of the stable review cycle for the 2.6.17.8 release.
> > There are 23 patches in this series, all will be posted as a response to
> > this one.  If anyone has any issues with these being applied, please let
> > us know.  If anyone is a maintainer of the proper subsystem, and wants
> > to add a Signed-off-by: line to the patch, please respond with it.
> >
> > These patches are sent out with a number of different people on the Cc:
> > line.  If you wish to be a reviewer, please email stable@kernel.org to
> > add your name to the list.  If you want to be off the reviewer list,
> > also email us.
> >
> > Responses should be made by Sunday, August 6, 05:00:00 UTC.  Anything
> > received after that time might be too late.
> >
> > I've also posted a roll-up patch with all changes in it if people want
> > to test it out.  It can be found at:
> >
> >         kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17.8-rc1.gz
> >
> 
> Any chance that the fixes in the (latest) e1000 driver version
> 7.1.9-k4 will get backported?

The post-2.6.17 e1000 changes are massive.

> I can't run 2.6.17.7 on at least one of my servers due to bugs in the
> driver that are fixed in the latest e1000 version.
> I looked through the -stable patches but didn't find anything that
> would fix my problem.
> I get messages along the lines of "kernel: Virtual device XXX asks to
> queue packet!" and the device then refuses to work.
> The last kernel where I know for a fact that it worked OK is 2.6.11,
> so that's what the server is currently running.
> 
> Getting the fix for that problem backported to -stable would really make my day.


Perhaps the e1000 developers can help us to identify the particular fix for
this problem.

That's assuming that it is actually fixed.  Does 2.6.18-current fix the bug?
