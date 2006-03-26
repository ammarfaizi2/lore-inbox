Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWCZNPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWCZNPI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 08:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWCZNPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 08:15:08 -0500
Received: from box.punkt.pl ([217.8.180.66]:64155 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S932087AbWCZNPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 08:15:07 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Rob Landley <rob@landley.net>
Subject: Re: State of userland headers
Date: Sun, 26 Mar 2006 15:12:56 +0200
User-Agent: KMail/1.9.1
Cc: llh-discuss@lists.pld-linux.org, linux-kernel@vger.kernel.org
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <200603231804.35817.rob@landley.net>
In-Reply-To: <200603231804.35817.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603261512.56996.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 00:04, Rob Landley wrote:
> You also don't want to run a libc built with newer headers than the kernel
> you're running on, or it'll try to use stuff that isn't there.
>
> You're saying that the new kernel headers wouldn't be versioned using the
> kernel's release numbers.  How do we know what kernel version their feature
> set matches then?  (I'm confused.  This happens easily...)

That's a tradeoff. You either version the headers just like I did, meaning 
that a given version corresponds to a given kernel, but that means you can't 
release before all of the archs are fully updated (and not relying on a 
single person to do all of the updates is one of the points of the exercise; 
and with more people, one can have delays) or you're forced to figure out 
some other way to version the headers.

-- 
Judge others by their intentions and yourself by your results.
                                                                 Guy Kawasaki
Education is an admirable thing, but it is well to remember from
time to time that nothing that is worth knowing can be taught.
                                                                  Oscar Wilde
