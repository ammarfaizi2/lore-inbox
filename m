Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWIAIWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWIAIWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWIAIV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:21:59 -0400
Received: from ns2.suse.de ([195.135.220.15]:12224 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750872AbWIAIVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:21:45 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/8] Implement per-processor data areas for i386.
Date: Fri, 1 Sep 2006 10:16:45 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060901064718.918494029@goop.org>
In-Reply-To: <20060901064718.918494029@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609011016.45600.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 September 2006 08:47, Jeremy Fitzhardinge wrote:
> [ Changes since previous post:
>   - fixed UP build
>   - make compiler type-check for writes to PDA
>   - added pda_addr() to get the address of PDA fields ]

I applied it now, with one change. I replaced the %Ps with %cs because
that is apparently the more official way to do that in gcc. Please
change that in your copy too.

There unfortunately were still quite a lot of rejects because -mm* 
is too different from mainline, but I fixed them all.

-Andi

