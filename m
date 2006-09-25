Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWIYVF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWIYVF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWIYVF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:05:26 -0400
Received: from mail.suse.de ([195.135.220.2]:24222 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751280AbWIYVFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:05:25 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/6] Initialize the per-CPU data area.
Date: Mon, 25 Sep 2006 23:05:10 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Matt Tolentino <matthew.e.tolentino@intel.com>
References: <20060925184540.601971833@goop.org> <200609252249.54901.ak@suse.de> <45184318.6060807@goop.org>
In-Reply-To: <45184318.6060807@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609252305.10239.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 September 2006 22:59, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > If this is really 1/1 why does it patch a file called pda.h? 
> >
> > I've thrown away the local pda patches before this because I assumed
> > you started fresh.
> >
> > Somehow I'm not surprised that nothing applies.  You seem to always
> > start with some random tree that nobody else has.
> >   
> Well, it's based on -mm, but I guess that includes pieces of your patch 
> series.  I was a bit surprised to see pda.h still in -mm with the rest 
> dropped.

I see.  Andrew reverted some stuff to fix his PII (which I broke BTW
it wasn't a problem in your original patches) but he didn't revert everything
only starting from the bisected patch.

Ok on the next resync everything will be dropped there.
 
> > Anyways, this patchkit has caused so much trouble and churn that I'll drop
> > it for now until after the .19 merge is done.
> >   
> I'll respin it against your patches later today.

Thanks. It's not that urgent because the merge will need a few days
at least.

Also I must admit I haven't figured out yet if yours or Rusty's patchkit
is better. So far I was leaning towards yours, but that might be because
I haven't looked closely at Rusty's version.

-Andi
