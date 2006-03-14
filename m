Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751888AbWCNVaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbWCNVaD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWCNVaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:30:03 -0500
Received: from mx2.netapp.com ([216.240.18.37]:45963 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1751888AbWCNVaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:30:00 -0500
X-IronPort-AV: i="4.02,191,1139212800"; 
   d="scan'208"; a="367116500:sNHT81167576"
Subject: Re: [PATCH] sunrpc svc: be quieter
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Daniel Drake <dsd@gentoo.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       okir@monad.swb.de
In-Reply-To: <441733C0.5040605@gentoo.org>
References: <20060305005532.5E7A0870504@zog.reactivated.net>
	 <Pine.LNX.4.61.0603051451590.30115@yvahk01.tjqt.qr>
	 <1141678330.31680.13.camel@lade.trondhjem.org>
	 <441733C0.5040605@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Tue, 14 Mar 2006 16:29:19 -0500
Message-Id: <1142371759.7987.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 14 Mar 2006 21:29:20.0278 (UTC) FILETIME=[5AF8E360:01C647AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 21:21 +0000, Daniel Drake wrote:
> Trond,
> 
> Trond Myklebust wrote:
> > They are probably trying to ping the server with a NULL procedure call
> > to test for service availability. We should allow that particular
> > usage...
> 
> Thanks, that sounds likely. Can you give some hints as to how a NULL 
> procedure call might appear? Would testing for prog==0 and/or proc==0 be 
> appropriate?

I can't see that authorising calls to prog==0 could ever be useful (what
would that mean?), but proc==0 is another matter: that is precisely the
NULL procedure call that I mentioned above.

Cheers,
  Trond
