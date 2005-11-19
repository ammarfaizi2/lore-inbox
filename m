Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVKSRde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVKSRde (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 12:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVKSRdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 12:33:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750725AbVKSRdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 12:33:33 -0500
Date: Sat, 19 Nov 2005 09:33:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH 4/5] slab: extract slab order calculation to separate
 function
Message-Id: <20051119093310.281ffbc2.akpm@osdl.org>
In-Reply-To: <437F199C.9040505@colorfullife.com>
References: <iq5uuh.o9kcui.7v9w5djupiovhrqo6are97fi6.beaver@cs.helsinki.fi>
	<437F199C.9040505@colorfullife.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> >+	} else
>  >+		left_over = calculate_slab_order(cachep, size, align, flags);
>  >  
>  >
> 
>  I usually add braces in this case: If braces are necessary for either 
>  the if or the else-clause, then I add braces to both parts.
> 
>  Could be applied as is, or I could write a patch with both changes.
>  Andrew - what do you prefer?

I normally add the braces in both legs of the `if' if one leg needs them. 
But it looks crappy either way, so whatever.  
