Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUD2Cip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUD2Cip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUD2Cip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:38:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63389 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262388AbUD2Cim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:38:42 -0400
Date: Wed, 28 Apr 2004 22:38:26 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Ian Stirling <ian.stirling@mauve.plus.com>
cc: Marc Boucher <marc@linuxant.com>, Timothy Miller <miller@techsource.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <40906A35.3090004@mauve.plus.com>
Message-ID: <Pine.LNX.4.44.0404282237430.19633-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Ian Stirling wrote:

> > Your new proposed message sounds much clearer to the ordinary mortal and 
> > would imho be a significant improvement. Perhaps printing repetitive 
> > warnings for identical $MODULE_VENDOR strings could also be avoided, 
> > taking care of the redundancy/volume problem as well..
> 
> Is this worth 100 or 200 bytes of code though?
> I'd have to say no.

I suspect it'll be worth it.  If only because it'll save
the kernel community from people asking things like:

"help, my kernel is tainted! what does it mean and how can I fix it?"

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

