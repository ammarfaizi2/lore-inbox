Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUD2CbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUD2CbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUD2CbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:31:11 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:37603 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S262370AbUD2CbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:31:07 -0400
In-Reply-To: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4150E18A-9985-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: Timothy Miller <miller@techsource.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Wed, 28 Apr 2004 22:31:01 -0400
To: Rik van Riel <riel@redhat.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rik,

Your new proposed message sounds much clearer to the ordinary mortal 
and would imho be a significant improvement. Perhaps printing 
repetitive warnings for identical $MODULE_VENDOR strings could also be 
avoided, taking care of the redundancy/volume problem as well..

Cheers
Marc

On Apr 28, 2004, at 8:02 PM, Rik van Riel wrote:

>
> I wouldn't be averse to changing the text the kernel prints
> when loading a module with an incompatible license. If the
> text "$MOD_FOO: module license '$BLAH' taints kernel." upsets
> the users, it's easy enough to change it.
>
> How about the following?
>
> "Due to $MOD_FOO's license ($BLAH), the Linux kernel community
> cannot resolve problems you may encounter. Please contact
> $MODULE_VENDOR for support issues."
>
>
>
> -- 
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
>

