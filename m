Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWD0KQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWD0KQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWD0KQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:16:58 -0400
Received: from ns2.suse.de ([195.135.220.15]:63209 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965071AbWD0KQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:16:57 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
References: <20060427014141.06b88072.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 27 Apr 2006 12:16:56 +0200
In-Reply-To: <20060427014141.06b88072.akpm@osdl.org>
Message-ID: <p73vesv727b.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc2/2.6.17-rc2-mm1/
> 
> 
> - It took six hours work to get this release building and linking in just a
>   basic fashion on eight-odd architectures.  It's getting out of control.

We all appreciate your hard work.
 
>   The acphphp driver is still broken and v4l and memory hotplug are, I
>   suspect, only hanging in there by the skin of their teeth.
> 
>   Could patch submitters _please_ be a lot more careful about getting the
>   Kconfig correct, testing various Kconfig combinations (yes sometimes
>   people will want to disable your lovely new feature) and just generally
>   think about these things a bit harder?  It isn't rocket science.

Is this something that could be automated with some machine power? 

e.g. every time a patch is added a small cluster could build the patches
with some configurations on various architectures and if it doesn't build 
autoflame the patch submitter.

We use this in SUSE for the SUSE kernels and it works quite well.

Maybe someone could contribute the build power needed for that. I suppose
it could be done by just a few scripts listening to mm-commits?

-Andi

