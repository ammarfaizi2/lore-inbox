Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWCZVS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWCZVS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWCZVS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:18:56 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:49082
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932124AbWCZVSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:18:55 -0500
From: Rob Landley <rob@landley.net>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 26 Mar 2006 16:18:29 -0500
User-Agent: KMail/1.8.3
Cc: Arjan van de Ven <arjan@infradead.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <1143394195.3055.1.camel@laptopd505.fenrus.org> <4426D609.2050700@argo.co.il>
In-Reply-To: <4426D609.2050700@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603261618.30090.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 March 2006 12:57 pm, Avi Kivity wrote:
> This is true for a small enough application. But things grow, libraries
> are added, and includes keep pulling other includes in. Sooner or later
> you'll have a collision.

And you'll fix it when it happens.  Fact of life.

> > The problem is things like u64 etc that is VERY common in all headers,
> > but then again __u64 etc are just fine, history has proven that already.
>
> Agree. But to be on the safe side one can use uint64_t and friends
> (which the kernel can typedef to u64 and first degree relatives)

Now that the kernel no longer targets gcc before 3.2, c99 names are merely 
ugly rather than an actual problem. :)

Rob
-- 
Never bet against the cheap plastic solution.
