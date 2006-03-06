Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbWCFUwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbWCFUwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWCFUwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:52:13 -0500
Received: from mx2.netapp.com ([216.240.18.37]:25971 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1751652AbWCFUwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:52:13 -0500
X-IronPort-AV: i="4.02,168,1139212800"; 
   d="scan'208"; a="365045738:sNHT19453976"
Subject: Re: [PATCH] sunrpc svc: be quieter
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Daniel Drake <dsd@gentoo.org>, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       okir@monad.swb.de
In-Reply-To: <Pine.LNX.4.61.0603051451590.30115@yvahk01.tjqt.qr>
References: <20060305005532.5E7A0870504@zog.reactivated.net>
	 <Pine.LNX.4.61.0603051451590.30115@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Mon, 06 Mar 2006 15:52:10 -0500
Message-Id: <1141678330.31680.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 06 Mar 2006 20:52:11.0243 (UTC) FILETIME=[D70F23B0:01C6415F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 14:52 +0100, Jan Engelhardt wrote:
> >
> >A Gentoo user at http://bugs.gentoo.org/124884 reports that the following
> >message appears in the logs over 650 times every day:
> >
> >	svc: unknown version (0)
> >
> Should not the clients be fixed?
> 

They are probably trying to ping the server with a NULL procedure call
to test for service availability. We should allow that particular
usage...

Cheers,
  Trond
