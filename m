Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263587AbUJ2Uw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbUJ2Uw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263577AbUJ2UvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:51:03 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:12671 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263548AbUJ2Ufu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:35:50 -0400
Date: Sat, 30 Oct 2004 00:36:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: Re: kbuild/all archs: Sanitize creating offsets.h
Message-ID: <20041029223624.GA18655@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028204430.C11436@flint.arm.linux.org.uk> <20041028215959.GA17314@mars.ravnborg.org> <20041028220024.D11436@flint.arm.linux.org.uk> <20041028234549.GB17314@mars.ravnborg.org> <20041029212852.GA16634@mars.ravnborg.org> <20041029205106.H31627@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029205106.H31627@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 08:51:06PM +0100, Russell King wrote:
> On Fri, Oct 29, 2004 at 11:28:52PM +0200, Sam Ravnborg wrote:
> > On Fri, Oct 29, 2004 at 01:45:49AM +0200, Sam Ravnborg wrote:
> > > On Thu, Oct 28, 2004 at 10:00:24PM +0100, Russell King wrote:
> > > > > Did you apply the patch that enabled kbuild files to be named Kbuild?
> > > > > It looks like this patch is missing.
> > > > 
> > > > I applied three patches.  The first was "kbuild: Prefer Kbuild as name of
> > > > the kbuild files"
> > > > 
> > > > > If you did apply the patch could you please check if the asm->asm-arm
> > > > > symlink exists when the error happens and that a file named Kbuild is
> > > > > located in the directory: include/asm-arm/
> > > 
> > > OK - I see it now.
> > > It's in i386 also - I will have a fix ready tomorrow. Thanks for testing!
> > 
> > Fix attached - next time I better check O= support myself.
> > Russell - I would be glad if you could test this version. There is 
> > some symlink handling for arm I like to see tested.
> 
> Getting better, but still not right:

Thanks.
Building arm toolchain atm so I can test myself.
The .arch stuff was the main reason to post arm.

	Sam
