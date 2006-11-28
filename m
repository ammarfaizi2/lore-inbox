Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758734AbWK1SkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758734AbWK1SkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758737AbWK1SkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:40:16 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:25980 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1758734AbWK1SkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:40:14 -0500
Message-ID: <456C82AE.6030505@cfl.rr.com>
Date: Tue, 28 Nov 2006 13:40:46 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu> <mj+md-20061128.131233.3594.atrey@ucw.cz> <456C704F.3050008@cfl.rr.com> <mj+md-200611 <mj+md-20061128.174904.27577.atrey@ucw.cz>
In-Reply-To: <mj+md-20061128.174904.27577.atrey@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Nov 2006 18:40:24.0030 (UTC) FILETIME=[AA496FE0:01C7131C]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14840.003
X-TM-AS-Result: No--8.357800-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Yes, but the point is that you cannot tell how much randomness is in the
> data you provide.

That is exactly my point.  Since you can not tell how much randomness is 
in the data you provide, you can not tell the kernel how much to add to 
its entropy estimate.  Instead it just has to estimate based on the 
amount of data you provide.

