Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbULTRCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbULTRCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbULTRCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:02:53 -0500
Received: from bristol.swissdisk.com ([65.207.35.130]:5597 "EHLO
	bristol.swissdisk.com") by vger.kernel.org with ESMTP
	id S261576AbULTRCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:02:38 -0500
Date: Mon, 20 Dec 2004 10:46:38 -0500
From: Ben Collins <bcollins@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arne Caspari <arnem@informatik.uni-bremen.de>,
       Adrian Bunk <bunk@stusta.de>, linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041220154638.GE457@phunnypharm.org>
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de> <20041220143901.GD457@phunnypharm.org> <1103555716.29968.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103555716.29968.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 03:15:18PM +0000, Alan Cox wrote:
> On Llu, 2004-12-20 at 14:39, Ben Collins wrote:
> > How about adding those exports into an config option ifdef that says
> > "Export extra IEEE-1394 symbols" and in the help explains that the symbols
> > may be needed for some third party modules. Give video-2-1394 as an
> > example.
> 
> You might as well remove the ifdef if you do that since vendors will
> have to guess what the right answer is an will probably uniformly say
> "Y". At that point its basically a non-option. Far better to submit the
> driver

You are missing the point though. Lots of these are part of our API, and
may be used at anytime. Lots of college kids are emailing me about
projects they are working on, and quite a few of them are using this API.
None of those projects will ever get out of the classroom, much less get
into the kernel mainline. But that API is needed, none-the-less, to expose
the internals of the system.

I'd hate to think that our "license" worries outweigh the small hacker
community for some projects.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
