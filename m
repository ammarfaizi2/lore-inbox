Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752062AbWFWVVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbWFWVVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbWFWVVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:21:39 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:9691 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1752062AbWFWVVi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:21:38 -0400
Date: Fri, 23 Jun 2006 23:19:21 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Danial Thom <danial_thom@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Measuring tools - top and interrupts
Message-ID: <20060623211921.GA18190@electric-eye.fr.zoreil.com>
References: <20060622235356.GA31168@electric-eye.fr.zoreil.com> <20060623203447.60105.qmail@web33311.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623203447.60105.qmail@web33311.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom <danial_thom@yahoo.com> :
[...]
> What's *fun* about it? 2.4.24 shows a 12-13%
> load. 

The assumption of linearity.

[...]
> > No difference when you renice ksoftirqd to a
> > strongly
> > negative value ?
> 
> No, not really. Running the compiler causes
> drops. re-nicing eliminates drops with no
> userland activity.

It may be interesting to know if the same drops
happen when you generate a disk-only load, ksoftirqd
still at the minimal value.

-- 
Ueimor
