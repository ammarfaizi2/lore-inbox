Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUAHPEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUAHPEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:04:20 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:24268 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S265114AbUAHPEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:04:14 -0500
Date: Thu, 8 Jan 2004 16:03:19 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Christoph Hellwig <hch@infradead.org>, Nathan Scott <nathans@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: Performance drop 2.6.0-test7 -> 2.6.1-rc2
Message-ID: <20040108160319.G29178@fi.muni.cz>
References: <20040107023042.710ebff3.akpm@osdl.org> <20040107215240.GA768@frodo> <20040108105427.E20265@fi.muni.cz> <20040108120739.A8987@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040108120739.A8987@infradead.org>; from hch@infradead.org on Thu, Jan 08, 2004 at 12:07:39PM +0000
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
: On Thu, Jan 08, 2004 at 10:54:27AM +0100, Jan Kasprzak wrote:
: > 	I have done further testing:
: > 
: > - this is reliable: repeated boot back to 2.6.1-rc2 makes the problem
: > 	appear again (high load, system slow has hell), booting back
: > 	to -test7 makes it disappear.
: 
: Can you put fs/xfs from -test7 into the 2.6.1-rc tree and test with that?

	I did that. Under 2.6.1-rc2 wit 2.6.0-test7 fs/xfs subtree the load
went up to >40 two minutes after boot.  So it is not XFS related.

	I have also ran hdparm -t (under a load, though) on all of my
physical disks, and the numbers on 2.6.1-rc2 seems to be more-or-less
the same as under 2.6.0-test7.

	Now I will try to boot 2.6.0-test9 and we will see if it is
similar to -rc2 or not.

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|  I actually have a lot of admiration and respect for the PATA knowledge  |
| embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
