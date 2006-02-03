Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945908AbWBCTTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945908AbWBCTTh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945910AbWBCTTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:19:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:5258 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1945911AbWBCTTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:19:35 -0500
Subject: Re: time function behaving strane
From: john stultz <johnstul@us.ibm.com>
To: Conio sandiago <coniodiago@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <993d182d0602022015j70bff250x2524c6c5917be2a7@mail.gmail.com>
References: <993d182d0602022015j70bff250x2524c6c5917be2a7@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 11:19:30 -0800
Message-Id: <1138994370.10057.129.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 09:45 +0530, Conio sandiago wrote:
> Hi all,
> i am using time function in my application.
> When i call the try function in a loop of say 1 lac iterations then i
> m facing strange behaviour.
> 
> What i am doing is that i am making a call twice to time function
> inside every iteration and i compare the time of both the calls.
> But sometimes the time obtained from recent call is 1 second less than
> the previous call.
> 
> Has anybody observed such kind of problem??

Time inconsistencies are possible with some hardware, although full
second inconsistencies are a bit large.

Please open a bug at  http://bugzilla.kernel.org

Attach a full dmesg log and assign it to me.

thanks
-john


