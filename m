Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVBJUb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVBJUb1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVBJUb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:31:26 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:4331 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261812AbVBJUbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:31:25 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
       Bill Davidsen <davidsen@tmr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391050210121756874a84@mail.gmail.com>
References: <1107695583.14847.167.camel@localhost.localdomain>
	 <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi>
	 <1108066096.4085.69.camel@tyrosine>
	 <9e473391050210121756874a84@mail.gmail.com>
Date: Thu, 10 Feb 2005 20:29:47 +0000
Message-Id: <1108067388.4085.74.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]
	Samsung P35, S3, black screen (radeon))
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 15:17 -0500, Jon Smirl wrote:
> On Thu, 10 Feb 2005 20:08:15 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > It also explicitly states that Windows 2000 and XP don't support this,
> > which leads me to suspect that vendors no longer expect POSTing to be
> > possible after initial system boot.
> 
> No, it means that some of my ATI cards don't function as secondary
> adapters on 2K and XP.

And nor will any other card that requires POSTing (assuming that it
isn't just ATI being less than honest about driver shortcomings). And
we've certainly seen in the past that removing support for functionality
in Windows tends to result in hardware no longer supporting that
functionality.

I have real, shipping hardware here that fails if you simply try to
execute the video BIOS POST code. If you think this is due to a
shortcoming in existing BIOS emulations, I'm more than happy to dump the
video and system BIOS regions and send them to you.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

