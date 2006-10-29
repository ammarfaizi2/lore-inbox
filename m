Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWJ2EuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWJ2EuJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 00:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWJ2EuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 00:50:09 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:60012 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965003AbWJ2EuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 00:50:07 -0400
Date: Sat, 28 Oct 2006 22:49:32 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Frustrated with Linux, Asus, and nVidia, and AMD
In-reply-to: <fa.i/oIAoig46I/apLGccQ0BesB0W8@ifi.uio.no>
To: Bill Davidsen <davidsen@tmr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Message-id: <454432DC.9030006@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.nWSYbiDM13Z4b2OlxoSzmqud/lI@ifi.uio.no>
 <fa.NxAEaSXPSQSEviWvGDBmTZn07UE@ifi.uio.no>
 <fa.i/oIAoig46I/apLGccQ0BesB0W8@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 2.6.18 is the latest released kernel, I don't think calling one release 
> back "ancient" is really advancing the solution. The problem seems to 
> have been reported in August, and is still not fixed, I do understand 
> that he would feel there is no progress.
> 
> How long will you wait before putting in the fix Marc Perkel suggested, 
> perhaps with a warning logged that it's a band-aid? Many users will not 
> be astute enough to find this discussion, the bug report, the fix, 
> configure and build a kernel, etc. And not all distributions will 
> address it either.

As far as the "fix" of disabling the skip-ACPI-timer-override, that is 
not something that can be put in the kernel as it will break other 
boards that require the ACPI timer override not to be used (like many 
nForce2 boards for example). Breaking working setups in order to fix 
others isn't acceptable.

There are clearly some NVIDIA chipsets which require the override be 
skipped, and some which require it not be. I think the ball is currently 
in NVIDIA's court to provide a way of figuring out which chipsets 
require the quirk and which don't..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

