Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUG3PYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUG3PYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 11:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267710AbUG3PYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 11:24:47 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:40461 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S267709AbUG3PYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 11:24:39 -0400
Date: Fri, 30 Jul 2004 17:24:33 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <20040730152433.GA47129@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com> <200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay> <m14qnr7u7b.fsf@ebiederm.dsl.xmission.com> <20040728133337.06eb0fca.akpm@osdl.org> <1091044742.31698.3.camel@localhost.localdomain> <m1llh367s4.fsf@ebiederm.dsl.xmission.com> <1091055311.31923.3.camel@localhost.localdomain> <20040728172204.2ecc5cdd.akpm@osdl.org> <1091109427.865.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091109427.865.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 02:57:09PM +0100, Alan Cox wrote:
> On Iau, 2004-07-29 at 01:22, Andrew Morton wrote:
> > btw, if we simply insert a five-second-pause, what problems does that
> > leave?  Network Rx, which is OK.  Disk writes will have completed (?). 
> > What remains?
> 
> Network RX is the obvious one since we've no idea where the DMA is
> going in memory.

Also audio and video capture on cyclic buffers can theorically go on
forever sending irqs from time to time while they're at it.

  OG.

