Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVAEXQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVAEXQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVAEXQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:16:41 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:50314 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262651AbVAEXO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:14:56 -0500
Message-ID: <41DC7542.8010305@sgi.com>
Date: Wed, 05 Jan 2005 17:16:18 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Longerbeam <stevel@mvista.com>
CC: Andi Kleen <ak@muc.de>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
References: <41DB35B8.1090803@sgi.com> <m1wtusd3y0.fsf@muc.de> <41DB5CE9.6090505@sgi.com> <41DC34EF.7010507@mvista.com> <41DC3E96.4020807@sgi.com> <41DC7193.60505@mvista.com>
In-Reply-To: <41DC7193.60505@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Longerbeam wrote:

> 
> you mean like a global mempolicy for the page cache? This shouldn't
> be difficult to integrate with my patch, ie. when allocating a page
> for the cache, first check if the mapping object has a policy (my patch),
> if not, then check if there is a global pagecache policy (your patch).
> 

Yes, I think thats exactly what I am thinking of.

I'll take a look at your patch and see what develops.  :-)
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
