Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVHMGwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVHMGwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 02:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVHMGwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 02:52:23 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:6284 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751319AbVHMGwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 02:52:22 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Date: Sat, 13 Aug 2005 16:51:07 +1000
User-Agent: KMail/1.8.2
Cc: vatsa@in.ibm.com, tony@atomide.com, tuukka.tikkanen@elektrobit.com,
       akpm@osdl.org, johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       ak@muc.de, schwidefsky@de.ibm.com, george@mvista.com
References: <20050812201946.GA5327@in.ibm.com> <200508131135.46558.kernel@kolivas.org>
In-Reply-To: <200508131135.46558.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508131651.08809.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2005 11:35, Con Kolivas wrote:
> On Sat, 13 Aug 2005 06:19, Srivatsa Vaddagiri wrote:
> > Hi,
> > 	Here's finally the SMP changes that I had promised. The patch
> > breaks the earlier restriction that all CPUs have to be idle before
> > cutting of timers and now allows each idle CPU to skip ticks independent
> > of others. The patch is against 2.6.13-rc6 and applies on top of Con's
> > patch maintained here:
>
> Great! Thanks.

I'm sorry to say this doesn't appear to skip any ticks on my single P4 with 
SMP/SMT enabled.

Con
