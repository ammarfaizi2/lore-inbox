Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267462AbUHDWYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267462AbUHDWYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267463AbUHDWYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:24:12 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:9883 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S267462AbUHDWYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:24:08 -0400
Subject: Re: MTRR driver model support broken on SMP.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408041712060.19619@montezuma.fsmlabs.com>
References: <1091585241.3303.6.camel@laptop.cunninghams>
	 <Pine.LNX.4.58.0408040119270.19619@montezuma.fsmlabs.com>
	 <1091596967.3189.86.camel@laptop.cunninghams>
	 <Pine.LNX.4.58.0408040128490.19619@montezuma.fsmlabs.com>
	 <1091597484.3191.90.camel@laptop.cunninghams>
	 <Pine.LNX.4.58.0408041712060.19619@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1091658271.2963.6.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 05 Aug 2004 08:24:32 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-08-05 at 07:15, Zwane Mwaikambo wrote:
> On Wed, 4 Aug 2004, Nigel Cunningham wrote:
> 
> > Okay. So the question then is how to get them restored. I don't
> > understand much about the driver model, but it seems to me that all we
> > should need it get to mtrr save/restore done from the

Wow. That's atrocious typing. Think more, type slower :>

> > drivers_suspend/resume calls, which do have interrupts enabled. But how
> > to achieve that...
> 
> Indeed, i can't see an easy way without writing it up as a "normal"
> driver. It'd be nice if we could avoid adding more infrastructure, i'll
> give it some more thought.

Me too. I have another patch I'm finishing off, then I'll see if I can
come up with one for this.

Nigel

