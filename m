Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVJRANj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVJRANj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVJRANj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:13:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31128 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751388AbVJRANi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:13:38 -0400
Date: Tue, 18 Oct 2005 02:13:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-pm] 2.6.14-rc1-mm1: usb breaks suspend
Message-ID: <20051018001337.GA15226@atrey.karlin.mff.cuni.cz>
References: <20051017100134.GA1764@elf.ucw.cz> <Pine.LNX.4.44L0.0510171450460.4446-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0510171450460.4446-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In -mm, usb breaks suspend to disk. Compiled without
> > CONFIG_USB_SUSPEND, it just plainly fails; iwth USB_SUSPEND, it
> > actually tries to suspend USB, but it fails and machine refuses to
> > suspend. Is it known or is it worth debugging?
> 
> More details please.
> 
> 2.6.14-rc1 is a little old by now.  With 2.6.14-rc4 I don't know

2.6.14-rc4-mm1, sorry.

> about -mm, but there's a problem with the uhci-hcd driver in Greg K-H's
> tree.  I submitted a patch earlier today:
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=112956023807659&w=2

Yes, this patch helps. [I still get quite a lot of debug messages, but
that's another story].
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
