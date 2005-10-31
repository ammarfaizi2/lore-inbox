Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVJ3Xum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVJ3Xum (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 18:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVJ3Xum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 18:50:42 -0500
Received: from ns.suse.de ([195.135.220.2]:40849 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751264AbVJ3Xul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 18:50:41 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: New (now current development process)
Date: Mon, 31 Oct 2005 01:48:56 +0100
User-Agent: KMail/1.8
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051029223723.GJ14039@flint.arm.linux.org.uk> <20051030111241.74c5b1a6.akpm@osdl.org>
In-Reply-To: <20051030111241.74c5b1a6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310148.57021.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 20:12, Andrew Morton wrote:

> The freezes are for fixing bugs, especially recent regressions.  There's no
> shortage of them, you know.
>
> I you can think of a better way to get kernel developers off their butts
> and actually fixing bugs, I'm all ears.

The problem is that you usually cannot do proper bug fixing because
the release might be just around the corner, so you typically
chose the ugly workaround or revert, or just reject changes for bugs that a 
are too risky or the impact too low because there is not enough time to 
properly test anymore.

It might work better if we were told when the releases would actually
happen and you don't need to fear that this not quite tested everywhere
bugfix you're about to submit might make it into the gold kernel, breaking
the world for some subset of users.

-Andi
