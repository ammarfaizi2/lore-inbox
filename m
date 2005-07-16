Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVGPQgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVGPQgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 12:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVGPQgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 12:36:47 -0400
Received: from gherkin.frus.com ([192.158.254.49]:28620 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S261658AbVGPQgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 12:36:47 -0400
Subject: Re: 2.6.12 vs. /sbin/cardmgr
In-Reply-To: "from (env: rct) at Jul 15, 2005 11:01:39 pm"
To: linux@dominikbrodowski.net
Date: Sat, 16 Jul 2005 11:36:45 -0500 (CDT)
CC: linix-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20050716163645.8FD8DDBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rct wrote:
> Dominik Brodowski wrote:
> > On Sun, Jul 10, 2005 at 03:37:22PM -0500, Bob Tracy wrote:
> > > Dominik Brodowski wrote:
> > > > On Sat, Jul 09, 2005 at 12:12:17AM -0500, Bob Tracy wrote:
> > > > > (/sbin/cardmgr chewing up lots of CPU cycles with 2.6.12 kernel)
> > > > 
> > > > Please post the output of "lspci" and "lsmod" as I'd like to know which
> > > > kind of PCMCIA bridge is in your notebook.
> > 
> > OK, it's a plain TI1225. Could you try whether the bug is still existent in
> > 2.6.13-rc3, please?
> 
> 2.6.13-rc3 works fine here.  The "cardmgr" process is no longer chewing
> up lots of CPU time, and otherwise seems to be working correctly.  Thanks!

I spoke too soon :-(.  The first boot on 2.6.13-rc3 was fine.  Every
boot since then has reflected no change relative to the 2.6.12 behavior.
The "cardmgr" process racks up CPU time almost as fast as time
elapses: it's at the top of the "top" list.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
