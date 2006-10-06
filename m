Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbWJFXG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWJFXG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWJFXG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:06:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:10415 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932660AbWJFXGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:06:55 -0400
Message-ID: <4526E175.9090608@garzik.org>
Date: Fri, 06 Oct 2006 19:06:29 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Duran, Leo" <leo.duran@amd.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
References: <1449F58C868D8D4E9C72945771150BDF46F8FD@SAUSEXMB1.amd.com>
In-Reply-To: <1449F58C868D8D4E9C72945771150BDF46F8FD@SAUSEXMB1.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duran, Leo wrote:
> OK, lets' take K8 processor performance states (p-states) as an example:
> BIOS, which should know 'best' about a given platform, needs to
> communicate to the OS what 'voltage' (VID code) is correct for given
> 'frequency' (FID),
> and it can do that via ACPI processor tables (_PSS). Otherwise, OS code
> is left with having to manage a HUGE amount 'specifics' (processor
> models), and endless driver revisions to account for new parts.
> 
> So, one can argue that there's merit on having ACPI, it's just a shame
> when BIOS doesn't get it right! (thus the justification for lack of
> 'trust'... the same can probably be said about other BIOS issues, not
> just ACPI)

That's pretty much it in a nutshell...  Since most BIOS are largely 
tested and qualified only on That Other OS, Linux often gets the short 
end of the stick.  We have a long history of running into BIOS bugs, and 
having to work around them.  We've learned the hard way that programming 
the "bare metal" is often the only reliable way to get things done.

	Jeff



