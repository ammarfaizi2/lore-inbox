Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265846AbTFSRJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbTFSRJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:09:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23285 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265846AbTFSRJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:09:39 -0400
Subject: Re: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	sks
From: Robert Love <rml@mvista.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: george anzinger <george@mvista.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>, "Li, Adam" <adam.li@intel.com>
In-Reply-To: <20030619171950.GA936@rudolph.ccur.com>
References: <A46BBDB345A7D5118EC90002A5072C780DD16DB0@orsmsx116.jf.intel.com>
	 <3EF1DE35.20402@mvista.com>  <20030619171950.GA936@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1056043409.8770.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 19 Jun 2003 10:23:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 10:19, 'joe.korty@ccur.com' wrote:

> I posted a fix for this a month ago that was ignored.  Which is a
> good thing, since now that I look at it again, I don't care for the
> approach I took nor does it appear to be complete.

Ah, sorry for missing it. Other than that tertiary statement inside an
if ;) my patch is about the same.

Why do you think it is incomplete? It looks correct to me.

	Robert Love

