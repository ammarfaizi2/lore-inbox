Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVJQPnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVJQPnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVJQPnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:43:24 -0400
Received: from ns1.suse.de ([195.135.220.2]:25014 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751401AbVJQPnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:43:24 -0400
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Mon, 17 Oct 2005 17:43:47 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, torvalds@osdl.org,
       shai@scalex86.org
References: <20051017093654.GA7652@localhost.localdomain> <200510171153.56063.ak@suse.de> <20051017153020.GB7652@localhost.localdomain>
In-Reply-To: <20051017153020.GB7652@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171743.47926.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 17:30, Ravikiran G Thirumalai wrote:

> Yes, I just saw Yasunori-san's patch.  Would that be merged for 2.6.14?

I think both are too risky at this point.

> 'Cause 2.6.14 is broken as of now for x86_64 boxes with more than 4G ram.

... that need swiotlb. Which makes that set much much smaller.
Sorry, but your scalex platform is definitely not anywhere release critical 
right now.

-Andi
