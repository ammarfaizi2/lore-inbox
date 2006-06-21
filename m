Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWFUNFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWFUNFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWFUNFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:05:52 -0400
Received: from mail.timesys.com ([65.117.135.102]:39073 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1751552AbWFUNFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:05:51 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
	dynamic HZ
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Felix Oxley <lkml@oxley.org>
Cc: mgross@linux.intel.com, Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <49ABE023-2FB8-4E74-B6CD-E647E4F6608F@oxley.org>
References: <1150643426.27073.17.camel@localhost.localdomain>
	 <449580CA.2060704@gmail.com>
	 <1150660202.27073.23.camel@localhost.localdomain>
	 <200606192209.38403.kernel@kolivas.org>
	 <1150720304.27073.70.camel@localhost.localdomain>
	 <20060619215822.GA4178@linux.intel.com>
	 <1150755573.6780.38.camel@localhost.localdomain>
	 <49ABE023-2FB8-4E74-B6CD-E647E4F6608F@oxley.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 15:07:14 +0200
Message-Id: <1150895235.6780.363.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 13:54 +0100, Felix Oxley wrote:
> On 19 Jun 2006, at 23:19, Thomas Gleixner wrote:
> 
> > FACTOR=20 batches the timer wheel timers to 40ms on a HZ=250 kernel
> 
> Should that read 80ms?

Doh, I lost my abacus and it's hard to find a good replacement :)

	tglx


