Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUKVVB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUKVVB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUKVVBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:01:38 -0500
Received: from [192.55.52.31] ([192.55.52.31]:35038 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262388AbUKVUzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:55:17 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411221234170.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe>
	 <Pine.LNX.4.58.0411200831560.20993@ppc970.osdl.org>
	 <1101150469.20006.46.camel@d845pe>
	 <Pine.LNX.4.58.0411221116480.20993@ppc970.osdl.org>
	 <1101155077.20006.110.camel@d845pe>
	 <Pine.LNX.4.58.0411221226310.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411221234170.20993@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1101156843.20006.142.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Nov 2004 15:54:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 15:36, Linus Torvalds wrote:
> 
> Oh, and I think one alternative at this point is obviously to just go
> back to the "re-enable all interrupts early in the boot" code. Clearly
> we need to do _something_ for 2.6.10, and I want it to be something
> that is pretty much equivalent to what we _do_ have testing coverage
> of. Just to keep safe.

I'm okay with this, and testing the interrupt fixes in -mm in the
mean-time -- particularly if you're planning a relatively short 2.6.10
rc cycle.

-Len


