Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbUBZPdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUBZPdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:33:37 -0500
Received: from pat.uio.no ([129.240.130.16]:41399 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262074AbUBZPdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:33:33 -0500
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: Andre Tomt <andre@tomt.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) status report
References: <403D5B3D.6060804@pobox.com>
	<200402260913.15379.m.watts@eris.qinetiq.com>
	<403DF26E.8020908@tomt.net>
	<200402261423.56448.m.watts@eris.qinetiq.com>
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Thu, 26 Feb 2004 16:33:25 +0100
In-Reply-To: <200402261423.56448.m.watts@eris.qinetiq.com> (Mark Watts's
 message of "Thu, 26 Feb 2004 14:23:56 +0000")
Message-ID: <wxxbrnl3lfe.fsf@nommo.uio.no>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Watts <m.watts@eris.qinetiq.com> writes:

> Andre Tomt wrote:
>
> > None of them. 3ware has its own chip, supported by the 3w-xxxx
> > driver in mainline 2.4 and 2.6. It's basicly exports the logical
> > arrays as SCSI devices.
> 
> Neat. Are there any known issues with these cards? (Do they work
> with AMD-64?)

  the 3w-xxxx-module works well enough in 32bit mode on AMD64.  sadly
  enough, we have had some other issues with 64bit mode, but the
  _driver_ seems to load there as well.  

-- 
Terje
