Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbVBEAkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbVBEAkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbVBEAkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:40:13 -0500
Received: from mxsf10.cluster1.charter.net ([209.225.28.210]:55940 "EHLO
	mxsf10.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S265351AbVBEAjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:39:51 -0500
X-Ironport-AV: i="3.88,180,1102309200"; 
   d="scan'208"; a="586881793:sNHT17542568"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16900.5586.511772.651559@smtp.charter.net>
Date: Fri, 4 Feb 2005 19:39:46 -0500
From: John Stoffel <john@stoffel.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] 2.6: USB disk unusable level of data corruption
In-Reply-To: <200502041241.28029.david-b@pacbell.net>
References: <1107519382.1703.7.camel@localhost.localdomain>
	<200502041241.28029.david-b@pacbell.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Is USB/SCSI just terminally broken under 2.6?  

David> I don't think so, but there are problems that appear in some
David> hardware configs and not others.  Many folk report no problems;
David> a (very) few report nothing but.

This is just a chime in to let people know others are seeing problems
with USB/SCSI external enclosures.

I haven't tried lately, but my USB/FireWire enclosure never worked
with Linux (or WinNT under firewire, sigh...) so I haven't touched it
in months.  Money down the drain.

David> If you've verified this on 2.6.10, then you certainly have have
David> the ehci-hcd (re)queueing race fix that has made a big
David> difference for some folk.  I don't know of any other issues in
David> that driver that could explain usb-storage problems.

I should try it again and see how it works under USB/Firewire, my last
attempts were under 2.6.[78] or so time frame.  

John
