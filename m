Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268324AbTGIN4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbTGIN4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:56:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64527 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268324AbTGIN4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:56:01 -0400
Date: Wed, 9 Jul 2003 15:10:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] fbdev and power management
Message-ID: <20030709151032.A22612@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	James Simmons <jsimmons@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org> <1057750557.514.22.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1057750557.514.22.camel@gaston>; from benh@kernel.crashing.org on Wed, Jul 09, 2003 at 01:35:58PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 01:35:58PM +0200, Benjamin Herrenschmidt wrote:
> Note: The Power Management isn't well implemented in 2.5 yet. The
> infrastructure is mostly there, but the driver side semantics are
> still wrong. Patrick Mochel has a new implementation that is much
> better, but he didn't merge it upstream yet. I expect this will
> happen around Kernel Summit / OLS.

I'm slightly concerned by this.  There are a growing amount of drivers
in 2.5 which are being made to work with the existing power management
system.  This "new" system seems to have been hanging around for about
4 months now with no visible further work, presumably so that a paper
can be presented before its release.

My concern is that there has been:
- 4 months of non-exposure of this work
- 4 months of making the current system work
- and putting it in will require a fair number of drivers to be 
  re-worked.

Apart from driver re-work and that the core interfaces are supposed to
be stable, what are the technical arguments against merging it, say,
today?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

