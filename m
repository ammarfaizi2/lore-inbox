Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751725AbWJGFY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbWJGFY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWJGFY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:24:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52699 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751710AbWJGFY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:24:26 -0400
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Duran, Leo" <leo.duran@amd.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <4526E175.9090608@garzik.org>
References: <1449F58C868D8D4E9C72945771150BDF46F8FD@SAUSEXMB1.amd.com>
	 <4526E175.9090608@garzik.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 07 Oct 2006 07:23:18 +0200
Message-Id: <1160198598.3000.134.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 19:06 -0400, Jeff Garzik wrote:
> Duran, Leo wrote:
> > OK, lets' take K8 processor performance states (p-states) as an example:
> > BIOS, which should know 'best' about a given platform, needs to
> > communicate to the OS what 'voltage' (VID code) is correct for given
> > 'frequency' (FID),
> > and it can do that via ACPI processor tables (_PSS). Otherwise, OS code
> > is left with having to manage a HUGE amount 'specifics' (processor
> > models), and endless driver revisions to account for new parts.
> > 
> > So, one can argue that there's merit on having ACPI, it's just a shame
> > when BIOS doesn't get it right! (thus the justification for lack of
> > 'trust'... the same can probably be said about other BIOS issues, not
> > just ACPI)
> 
> That's pretty much it in a nutshell...  Since most BIOS are largely 
> tested and qualified only on That Other OS, Linux often gets the short 
> end of the stick. 

fwiw we're trying to get this changed; Intel released the Linux-ready
firmware developer kit recently which is designed to make it real easy
for bios people to test their bios with linux....

see http://www.linuxfirmwarekit.org

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

