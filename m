Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbTENNRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbTENNRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:17:41 -0400
Received: from mail.hometree.net ([212.34.181.120]:59820 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S262191AbTENNRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:17:40 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Date: Wed, 14 May 2003 13:30:27 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b9tgdj$e3m$2@tangens.hometree.net>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de> <20030512195331.GD10089@gtf.org> <20030513064059.GL17033@suse.de> <20030513180020.GB3309@suse.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1052919027 14454 212.34.181.4 (14 May 2003 13:30:27 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 14 May 2003 13:30:27 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

>On Tue, May 13, 2003 at 08:40:59AM +0200, Jens Axboe wrote:
> > > Weird.  Mine doesn't seem to assert it, nor does the identify page
> > > indicate it's supported.  Maybe I have a broken drive firmware.
> > 
> > Then the linux code won't work on it, have you tried? I've tried a lot
> > of different IBM models, they all do service interrupts just fine.

>bug in the firmware version on Jeffs drives perhaps ?

As he has an old firmware on the drive (which he really should
upgrade, else it will eat his drive sooner or later), this might well
be possible.

> > I can confirm that. This drive Model=IBM-DTLA-307045, FwRev=TX6OA60A,
> > SerialNo=YMCYMT3Y229 has eaten my filesystem with TCQ on 2.5.69

Most current I got my fingers on is A6AA (last four letters of the
FwRev).  I'd recommend an update. Even better: Sell the drive on eBay.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
