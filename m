Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbUKVU0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbUKVU0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbUKVU0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:26:20 -0500
Received: from fmr01.intel.com ([192.55.52.18]:57756 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262492AbUKVUZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:25:43 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411221116480.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe>
	 <Pine.LNX.4.58.0411200831560.20993@ppc970.osdl.org>
	 <1101150469.20006.46.camel@d845pe>
	 <Pine.LNX.4.58.0411221116480.20993@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1101155077.20006.110.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Nov 2004 15:24:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 14:23, Linus Torvalds wrote:


> To me, firmware is not
> something cool to be used. It's a necessary evil, and it should be
> avoided and mistrusted as far as humanly possible, because it is
> always buggy, and we can't fix the bugs in it.

Mistrusting firmware is why I disabled all the links, some system
firmware didn't leave them in a self-consistent state.

Re: liking ACPI
Consider it a love/hate thing;-)

> > The damn good reason is that doing otherwise breaks systems.
> 
> And not doing it breaks systems.

I'm not aware (yet) of any systems where disabling all the links (which
we've been doing since June, BTW) and clearing the entire ELCR, and then
re-enabling them both only as we use them causes a failure.

> This is why I don't trust firmware. It's always buggy.

I'm with you on that one.

-Len


