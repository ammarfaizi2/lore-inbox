Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbVKBFEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVKBFEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVKBFEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:04:48 -0500
Received: from dvhart.com ([64.146.134.43]:26026 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751498AbVKBFEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:04:47 -0500
Date: Tue, 01 Nov 2005 21:04:52 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, Rob Landley <rob@landley.net>
Cc: ak@suse.de, rmk+lkml@arm.linux.org.uk, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <221880000.1130907891@[10.10.2.4]>
In-Reply-To: <20051030231723.71c72865.akpm@osdl.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com><20051030111241.74c5b1a6.akpm@osdl.org><200510310148.57021.ak@suse.de><200510302305.46532.rob@landley.net> <20051030231723.71c72865.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's what I was thinking ;)
> 
> The simple fact is that we have more developers doing more stuff faster
> than they used to.  All within a coupled system which has a lot of
> interactions.
> 
> End result: yes, we do all need to spend more time looking at other
> people's code and less time looking at our own.  That's just life in a
> large project.
> 
> I'm very careful to make sure that relevant developers are copied on
> patches which go into -mm.  In fact there's significantly better review
> opportunity on patches which go developer->mm->Linus than there are on
> patches which go developer->maintainer-git->Linus.

Moreover, it's fairly easy to test stuff that's all in one place, in a
consistent format, with a simple linear stack of patches to sort through 
to find culprits.

Plus you have a great tendency of dropping stuff like a stone when it's
broken, which helps a lot. Having some basic pre-mainline-merge testing
keeps the quality of mainline way up.

It'd help more if people focused more on testing their own shit before
submitting it than complaining about -mm. If it's the same people breaking 
the tree all the time, I'm sure we can find a recycled set of stocks 
somewhere.

M.

