Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbVKYN2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbVKYN2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbVKYN2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:28:22 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:32163 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932687AbVKYN2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:28:22 -0500
Subject: Re: duration of udelay differs with activated realtime-preempt
	patch?
From: Steven Rostedt <rostedt@goodmis.org>
To: "Schultheiss, Christoph" <Christoph.Schultheiss@eurocopter.com>
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <B7DA45CF87D412408436D5ECAAB9B90F6E7A06@sma2906.cr.eurocopter.corp>
References: <B7DA45CF87D412408436D5ECAAB9B90F6E7A06@sma2906.cr.eurocopter.corp>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 08:28:05 -0500
Message-Id: <1132925285.6694.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-25 at 11:26 +0100, Schultheiss, Christoph wrote:
> kernel: 2.6.14 with and without the realtime-preempt patch
> 
> hi list,
> 
> after measuring the duration of the function udelay (with oscilloscope
> at parallel port), I figured out that udelay (5usec) with activated
> realtime- preempt patch lasts a little bit longer. Without the patch the
> time is exact.
> All kernel debug switches are turned off at compile time.
> Can anyone suggest why this happens?

Well, the -rt patch, has changed the udelay function.  BTW, you are
using the constant udelay, right?  Maybe an example of the code you used
to test might be useful.

Ingo or John?

-- Steve


