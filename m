Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWCYDUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWCYDUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 22:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWCYDUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 22:20:32 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32478
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750702AbWCYDUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 22:20:31 -0500
From: Rob Landley <rob@thyrsus.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: State of userland headers
Date: Fri, 24 Mar 2006 22:19:54 -0500
User-Agent: KMail/1.8.3
Cc: Nix <nix@esperi.org.uk>, Mariusz Mazur <mmazur@kernel.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
In-Reply-To: <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603242219.54677.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 5:46 pm, Kyle Moffett wrote:

> however.  Since the kabi/*.h headers would not be kernel-version-
> specific, they could be copied to a system running an older kernel
> and reused there without problems.

Since when is the kernel ABI not kernel version specific?  You can use an 
older ABI on a newer kernel, but you can't use a newer ABI on an older 
kernel.

> Even though some of the syscalls 
> and ioctls referenced in the kabi headers might not be present on the
> running kernel, portable programs are expected to be able to sanely
> handle older kernels.

At the source level, maybe.  At the binary level?  Not really.

Rob
-- 
Never bet against the cheap plastic solution.
