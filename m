Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWBJRGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWBJRGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWBJRGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:06:13 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:45838 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751325AbWBJRGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:06:13 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: ata1: command 0x35 timeout sata_nv driver
Date: Fri, 10 Feb 2006 17:06:17 +0000
User-Agent: KMail/1.9.1
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
References: <43ECB9EA.9000804@perkel.com> <200602101730.47512.prakash@punnoor.de>
In-Reply-To: <200602101730.47512.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101706.17898.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 16:30, Prakash Punnoor wrote:
> Am Freitag Februar 10 2006 17:06 schrieb Marc Perkel:
> > Are there still problems with sata_nv?
> >
> > Running 2 maxtor 250gig drives with 16mb buffer.
> >
> > Getting this error:
> > ata1: command 0x35 timeout, stat 0x50 hos_stat 0x24
> > ata2: command 0x35 timeout, stat 0x50 hos_stat 0x24
>
> Maxtor released a new BIOS fixing issues with nforce4. Maybe you want to
> ask bios for the fw and test it?

I've got 2x200GB DiamondMax 10s running on a sata_nv ports with no issues 
whatsoever. This problem is more likely to be a software issue on the 
controller side.

Let's see a .config for this machine? Have you successfully used the sata 
ports prior to these HDs?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
