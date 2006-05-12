Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWELOTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWELOTt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWELOTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:19:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:34013 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932089AbWELOTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:19:48 -0400
Date: Fri, 12 May 2006 16:19:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, nickpiggin@yahoo.com.au,
       haveblue@us.ibm.com, bob.picco@hp.com, mbligh@mbligh.org, ak@suse.de,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] Zone boundry alignment fixes
Message-ID: <20060512141921.GA564@elte.hu>
References: <445DF3AB.9000009@yahoo.com.au> <exportbomb.1147172704@pinky> <20060511005952.3d23897c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511005952.3d23897c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> There's some possibility here of interaction with Mel's "patchset to 
> size zones and memory holes in an architecture-independent manner." I 
> jammed them together - let's see how it goes.

update: Andy's 3 patches, applied to 2.6.17-rc3-mm1, fixed all the 
crashes and asserts i saw. NUMA-on-x86 is now rock-solid on my testbox. 
Great work Andy!

	Ingo
