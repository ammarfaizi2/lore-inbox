Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291259AbSBGUKO>; Thu, 7 Feb 2002 15:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291261AbSBGUJ5>; Thu, 7 Feb 2002 15:09:57 -0500
Received: from zero.tech9.net ([209.61.188.187]:21008 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291259AbSBGUJn>;
	Thu, 7 Feb 2002 15:09:43 -0500
Subject: Re: [RFC] New locking primitive for 2.5
From: Robert Love <rml@tech9.net>
To: yodaiken@fsmlabs.com
Cc: Martin Wirth <Martin.Wirth@dlr.de>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au, torvalds@transmet.com, mingo@elte.hu, nigel@nrg.org
In-Reply-To: <20020207125853.B21354@hq.fsmlabs.com>
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <1013107259.10430.29.camel@phantasy>
	 <20020207125853.B21354@hq.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Feb 2002 15:08:02 -0500
Message-Id: <1013112523.9534.75.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-07 at 14:58, yodaiken@fsmlabs.com wrote:

> On Thu, Feb 07, 2002 at 01:40:59PM -0500, Robert Love wrote:
> > We shouldn't engage in wholesale changing of spinlocks to semaphores
> > without a priority-inheritance mechanism.  And _that_ is the bigger
> > issue ...
> 
> Cool. We can then have the Solaris "this usually doesn't fail on test" priority
> inherit read/write lock.  I can hardly wait.

Or, we could do things right and not.

	Robert Love

