Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVADDLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVADDLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 22:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVADDLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 22:11:17 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:51667 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261982AbVADDLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 22:11:14 -0500
From: Mark Williamson <maw48@cl.cam.ac.uk>
To: xen-devel@lists.sourceforge.net
Subject: Re: [Xen-devel] Re: [XEN] using shmfs for swapspace
Date: Tue, 4 Jan 2005 03:04:09 +0000
User-Agent: KMail/1.7.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050102162652.GA12268@lkcl.net> <20050103205318.GD6631@lkcl.net> <1104785749.13302.26.camel@localhost.localdomain>
In-Reply-To: <1104785749.13302.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501040304.10128.maw48@cl.cam.ac.uk>
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> for doing opportunistic page recycling ("I dont need this page but when
> I ask for it back please tell me if you trashed the content")

We've talked about doing this but AFAIK nobody has gotten round to it yet 
because there hasn't been a pressing need (IIRC, it was on the todo list when 
Xen 1.0 came out).

IMHO, it doesn't look terribly difficult but would require (hopefully small) 
modifications to the architecture independent code, plus a little bit of 
support code in Xen.

I'd quite like to look at this one fine day but I suspect there are more 
useful things I should do first...

Cheers,
Mark
