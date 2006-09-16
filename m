Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWIPPtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWIPPtM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 11:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWIPPtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 11:49:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:36521 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932443AbWIPPtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 11:49:10 -0400
Message-ID: <450C1CF2.4080308@garzik.org>
Date: Sat, 16 Sep 2006 11:49:06 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Tejun Heo <htejun@gmail.com>, Tom Mortensen <tmmlkml@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.x libata resync
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com> <20060916053713.GJ541@1wt.eu> <450B9940.5030609@gmail.com> <20060916063808.GK541@1wt.eu>
In-Reply-To: <20060916063808.GK541@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> There are a bunch of small patches in the early 2.6 version which look
> like bugfixes, but with non-descriptive comments, so I'm not sure what
> they fix. Several of them would apply to 2.4, but I don't want to touch
> this area as long as nobody complains about problems.

Oh there are tons of SATA bug fixes that 2.4.x is missing.  One of the 
biggest is the completely crappy exception handling.  If a SATA device 
is unplugged or spazzes out, the system may or may not recover.

	Jeff


