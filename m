Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTIAWBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbTIAWBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:01:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17159 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263298AbTIAWBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:01:09 -0400
Date: Mon, 1 Sep 2003 23:00:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Henrik Persson <nix@syndicalist.net>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, pclark@SLAC.Stanford.EDU,
       linux-kernel@vger.kernel.org
Subject: Re: orinoco wireless driver
Message-ID: <20030901230059.E22682@flint.arm.linux.org.uk>
Mail-Followup-To: Henrik Persson <nix@syndicalist.net>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	pclark@SLAC.Stanford.EDU, linux-kernel@vger.kernel.org
References: <x34vfscwgq8.fsf@bbrcu5.slac.stanford.edu> <20030901174437.GK10584@conectiva.com.br> <20030901202251.066AD3FA2A@procyon.nix.homeunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030901202251.066AD3FA2A@procyon.nix.homeunix.net>; from nix@syndicalist.net on Mon, Sep 01, 2003 at 10:22:50PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 10:22:50PM +0200, Henrik Persson wrote:
> On Mon, 1 Sep 2003 14:44:37 -0300
> Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
> 
> > humm, I saw this lots of times, care to try, after it is detected as
> > "memory" to do this:
> > 
> > cardctl eject
> > cardctl insert
> > 
> > and see if gets correctly detected this turn? works for me.
> 
> And restart cardmgr a couple of times and then ejecting and inserting..
> Those procedures are needed here. ;)

Daniel Ritz was going to run some tests on his TI PCI1410 based laptop,
but last I heard he didn't find anything wrong.  The mistery continues...

You might want to apply the patches on pcmcia.arm.linux.org.uk and see
if any of those help (and say which one.)

Frankly, I don't see this issue getting resolved any time soon.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
