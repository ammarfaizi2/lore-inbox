Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284756AbRLEWFI>; Wed, 5 Dec 2001 17:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284745AbRLEWEx>; Wed, 5 Dec 2001 17:04:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64525 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284756AbRLEWDw>; Wed, 5 Dec 2001 17:03:52 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux/Pro  -- clusters
Date: Wed, 5 Dec 2001 21:57:38 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9um58i$9no$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10112032057070.978-100000@vaio.greennet> <E16BBb1-0001KS-00@the-village.bc.nu> <20011204103010.A30650@stud.ntnu.no>
X-Trace: palladium.transmeta.com 1007589824 13605 127.0.0.1 (5 Dec 2001 22:03:44 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 5 Dec 2001 22:03:44 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011204103010.A30650@stud.ntnu.no>,
=?iso-8859-1?Q?Thomas_Lang=E5s?=  <thomas@langaas.org> wrote:
>Alan Cox:
>> >    a SCSI device layer that isn't three half-finished clean-ups
>> Beginning (at last)
>
>So there's someone fixing the SCSI-layer code now?   (It's marked as
>unmaintained in the MAINTAINERS-file for 2.4-kernels, at least)

The old SCSI code won't be fixed.  It will just be made totally obsolete
by the better generic block layer code.  I personally hope that a year
from now, if somebody wants to do a new SCSI driver, he won't even
_think_ about using the SCSI code, the driver will just take the
(generic SCSI) requests directly off the block queue. 

Death to middle-men that can't do a good job anyway.

		Linus
