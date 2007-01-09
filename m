Return-Path: <linux-kernel-owner+w=401wt.eu-S932544AbXAIXkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbXAIXkH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbXAIXkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:40:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:53999 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932544AbXAIXkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:40:05 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>,
       torvalds@osdl.org
Subject: Re: .version keeps being updated
References: <20070109102057.c684cc78.khali@linux-fr.org>
	<20070109170550.AFEF460C343@tzec.mtu.ru>
	<20070109214421.281ff564.khali@linux-fr.org>
	<20070109133121.194f3261.akpm@osdl.org>
	<Pine.LNX.4.64.0701091520280.3594@woody.osdl.org>
	<20070109152534.ebfa5aa8.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 10 Jan 2007 00:39:40 +0100
In-Reply-To: <20070109152534.ebfa5aa8.akpm@osdl.org>
Message-ID: <p7364bfkbwj.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Tue, 9 Jan 2007 15:21:51 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > 
> > 
> > On Tue, 9 Jan 2007, Andrew Morton wrote:
> > > 
> > > > This new behavior of the kernel build system is likely to
> > > > make developers angry pretty quickly.
> > > 
> > > That might motivate them to fix it ;)
> > 
> > Actually, how about just removing the incrementing version count entirely?
> 
> I use it pretty commonly to answer the question "did I remember to install
> that new kernel I just built before I rebooted"?  By comparing `uname -a'
> with $TOPDIR/.version.

I even have scripts that require this to identify kernels. Please don't
remove it.

-Andi
