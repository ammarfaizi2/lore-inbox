Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVGPEBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVGPEBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 00:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVGPEBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 00:01:46 -0400
Received: from gherkin.frus.com ([192.158.254.49]:53718 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S262180AbVGPEBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 00:01:44 -0400
Subject: Re: 2.6.12 vs. /sbin/cardmgr
In-Reply-To: <20050715172346.GD3586@isilmar.linta.de> "from Dominik Brodowski
 at Jul 15, 2005 07:23:46 pm"
To: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Fri, 15 Jul 2005 23:01:39 -0500 (CDT)
CC: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20050716040140.1F03FDBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> On Sun, Jul 10, 2005 at 03:37:22PM -0500, Bob Tracy wrote:
> > Dominik Brodowski wrote:
> > > On Sat, Jul 09, 2005 at 12:12:17AM -0500, Bob Tracy wrote:
> > > > (/sbin/cardmgr chewing up lots of CPU cycles with 2.6.12 kernel)
> > > 
> > > Please post the output of "lspci" and "lsmod" as I'd like to know which
> > > kind of PCMCIA bridge is in your notebook.
> 
> OK, it's a plain TI1225. Could you try whether the bug is still existent in
> 2.6.13-rc3, please?

2.6.13-rc3 works fine here.  The "cardmgr" process is no longer chewing
up lots of CPU time, and otherwise seems to be working correctly.  Thanks!

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
