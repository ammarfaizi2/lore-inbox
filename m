Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317971AbSGaWHV>; Wed, 31 Jul 2002 18:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318388AbSGaWHV>; Wed, 31 Jul 2002 18:07:21 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:46989 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S317971AbSGaWHU>; Wed, 31 Jul 2002 18:07:20 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Date: Wed, 31 Jul 2002 15:04:19 -0700 (PDT)
Subject: Re: [2.6] The List, pass #2
In-Reply-To: <Pine.LNX.3.96.1020731133038.10066A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0207311500210.1038-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > o Remove all hardwired drivers from kernel
>
> I really hope this means drivers MAY be used as modules, not MUST. There
> is some overhead in doing things as modules, and added complexity usually
> means "harder to debug." Particularly with modules where there can be
> corner conditions and races on [un]load.

Bill,
  Several people (IIRC including Alan Cox) would like to make many of the
modules (network cards and scsi drivers for example) mandatory, requiring
use of an initrd (or it's replacement) on all boot setups.


check the archives from about 4 months back for the discussion.

David Lang

