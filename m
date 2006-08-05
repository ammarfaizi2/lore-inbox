Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWHEBoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWHEBoJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 21:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbWHEBoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 21:44:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29919 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422701AbWHEBoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 21:44:06 -0400
Message-ID: <44D3F7E1.4030703@garzik.org>
Date: Fri, 04 Aug 2006 21:44:01 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: moreau francis <francis_moreau2000@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: [HW_RNG] How to use generic rng in kernel space
References: <20060804130030.90361.qmail@web25805.mail.ukl.yahoo.com> <200608042308.24421.mb@bu3sch.de>
In-Reply-To: <200608042308.24421.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> I am not a friend of a direct in-kernel hwrng access interface,
> because it may return crap data by definition. Many (all current)
> RNG devices may fail and return non-random data. If that's happily
> used by some in-kernel user by the interface, we are screwed.

Yes, this is the reason why we pass it through userspace...

	Jeff


