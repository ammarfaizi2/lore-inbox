Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312275AbSCYCk1>; Sun, 24 Mar 2002 21:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311961AbSCYCkR>; Sun, 24 Mar 2002 21:40:17 -0500
Received: from zero.tech9.net ([209.61.188.187]:32787 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312275AbSCYCkG>;
	Sun, 24 Mar 2002 21:40:06 -0500
Subject: Re: preempt-related hangs
From: Robert Love <rml@tech9.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5.1.0.14.2.20020325023128.03e40850@pop.cus.cam.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 24 Mar 2002 21:40:59 -0500
Message-Id: <1017024059.13082.15.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-03-24 at 21:33, Anton Altaparmakov wrote:

> Er, because you disable preemption twice and it never gets enabled again? (-:
> 
> You probably meant that to be preemt_enable() at the bottom of the patch... 
> That might not solve your problem of course... But with the patch you 
> basically have completely disabled preemption, you might as well not 
> configure it into the kernel. (-;

Crap - good eye Anton.  What does it do now, Andrew?

	Robert Love

