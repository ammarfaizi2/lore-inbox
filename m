Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261585AbSIXG4k>; Tue, 24 Sep 2002 02:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261586AbSIXG4k>; Tue, 24 Sep 2002 02:56:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59916 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261585AbSIXG4j>;
	Tue, 24 Sep 2002 02:56:39 -0400
Message-ID: <3D900DBA.6080400@pobox.com>
Date: Tue, 24 Sep 2002 03:01:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "'Andy Pfiffer'" <andyp@osdl.org>, cgl_discussion@osdl.org,
       "Rhoads, Rob" <rob.rhoads@intel.com>,
       hardeneddrivers-discuss@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Hardeneddrivers-discuss] RE: [cgl_discussion] Some Initial Comments
 on DDH-Spec-0.5h.pdf
References: <EDC461A30AC4D511ADE10002A5072CAD01FD8CEA@orsmsx119.jf.intel.com>	<3D8FC2DA.3010107@pobox.com> <m1k7lbkicd.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Oh, and don't forget that the hardware specification that drivers are
> written to, many times are not generally available greatly reducing 
> the pool of capable people who have the opportunity to review the and
> debug the drivers.  I would make it a requirement for a hardened
> driver that both the code and the hardware documentation be publicly
> available so the code can easily be reviewed by as many people as wish
> to.


This is a good point that bears highlighting.  Donald Becker's [and thus 
the kernel's] eepro100.c had certain bugs for years, simply because 
access to Intel E100 hardware docs was damn near impossible to obtain.

I don't see driver hardening being very feasible on such drivers, where 
the vendor refuses to allow kernel engineers access needed to get their 
hardware working and stable.  [why vendors want crappy Linux support, 
I'll never know]

	Jeff


P.S.  In all fairness, Intel is doing a really good job maintaining the 
e100 and e1000 drivers nowadays, and e100 docs should be public very 
soon.  [e1000 docs? who knows...]

