Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWCZU7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWCZU7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 15:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWCZU7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 15:59:45 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:12942
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751545AbWCZU7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 15:59:44 -0500
From: Rob Landley <rob@landley.net>
To: Mariusz Mazur <mmazur@kernel.pl>
Subject: Re: State of userland headers
Date: Sun, 26 Mar 2006 15:59:41 -0500
User-Agent: KMail/1.8.3
Cc: llh-discuss@lists.pld-linux.org, linux-kernel@vger.kernel.org
References: <200603141619.36609.mmazur@kernel.pl> <200603231804.35817.rob@landley.net> <200603261512.56996.mmazur@kernel.pl>
In-Reply-To: <200603261512.56996.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603261559.41706.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 March 2006 8:12 am, Mariusz Mazur wrote:
> On Friday 24 March 2006 00:04, Rob Landley wrote:
> > You also don't want to run a libc built with newer headers than the
> > kernel you're running on, or it'll try to use stuff that isn't there.
> >
> > You're saying that the new kernel headers wouldn't be versioned using the
> > kernel's release numbers.  How do we know what kernel version their
> > feature set matches then?  (I'm confused.  This happens easily...)
>
> That's a tradeoff. You either version the headers just like I did, meaning
> that a given version corresponds to a given kernel, but that means you
> can't release before all of the archs are fully updated (and not relying on
> a single person to do all of the updates is one of the points of the
> exercise; and with more people, one can have delays) or you're forced to
> figure out some other way to version the headers.

If somebody #includes <linux/version.h> from the new headers, and can 
determine what kernel version it goes with for their platform from that (even 
if the different platforms are out of sync), and said information also goes 
in a README or release notes or some such, I'll live.

Rob
-- 
Never bet against the cheap plastic solution.
