Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTFEHFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 03:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTFEHFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 03:05:52 -0400
Received: from smtp.sw.oz.au ([203.31.96.1]:17588 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S264490AbTFEHFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 03:05:51 -0400
Date: Thu, 5 Jun 2003 17:19:15 +1000
From: Kingsley Cheung <kingsley@aurema.com>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 764] New: btime in /proc/stat wobbles (even over 30 seconds)
Message-ID: <20030605171915.A29095@aurema.com>
Mail-Followup-To: Mike Dresser <mdresser_l@windsormachine.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <205830000.1054566142@[10.10.2.4]> <Pine.LNX.4.33.0306021107260.31561-100000@router.windsormachine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0306021107260.31561-100000@router.windsormachine.com>; from mdresser_l@windsormachine.com on Mon, Jun 02, 2003 at 11:08:01AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 11:08:01AM -0400, Mike Dresser wrote:
> On Mon, 2 Jun 2003, Martin J. Bligh wrote:
> 
> >            Summary: btime in /proc/stat wobbles (even over 30 seconds)
> >     Kernel Version: 2.5.70 but also in 2.2.20
> 
> Happens in 2.4.20 as well, it wobbles by one every couple seconds.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I raised this earlier in March this year. See:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104804927502272&w=2

I sent to Rusty trivial patch for the fix against 2.4.20 back then. 

-- 
		Kingsley
