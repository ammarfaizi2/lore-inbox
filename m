Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272046AbTG2UKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272048AbTG2UKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:10:12 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:38898 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S272046AbTG2UKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:10:02 -0400
Date: Tue, 29 Jul 2003 13:09:44 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org, <pgw99@doc.ic.ac.uk>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
In-Reply-To: <200307291915.h6TJF6YB000421@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0307291303580.10316-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, John Bradford wrote:

> > This patch adds an abstraction layer for programmable LED devices,
> > hardware drivers for the Status LEDs found on some Intel PIIX4E based
> > server hardware (notably the ISP1100 1U rackmount server) and LEDs wired
> > to the parallel port data lines.
> 
> I haven't had chance to test this yet, but I really like the idea - by
> an amasing co-incidence, I was actually thinking about the possibility
> of doing a parallel port connected front panel earlier today!
> 
> Does anybody have any suggestions for recommended standard uses for
> parallel port connected LEDs?
> 
> Disk spinning up/disk ready
> Root login active

provide a userspace interface and people will use it for all sorts of 
strange things...

email deliverly notification, varying levels of log messages and output, 
from lmsensors come to mind immediatly...
 
> Any other suggestions?
> 
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


