Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUD2UqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUD2UqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUD2Uj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:39:58 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:54400 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S264970AbUD2Uel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:34:41 -0400
Message-ID: <40916681.1040502@maine.rr.com>
Date: Thu, 29 Apr 2004 16:33:05 -0400
From: "David B. Stevens" <dsteven3@maine.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
In-Reply-To: <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> said:
> 
> [...]
> 
> 
>>I don't know. What if you have some huge application that only
>>runs once per day for 10 minutes? Do you want it to be consuming
>>100MB of your memory for the other 23 hours and 50 minutes for
>>no good reason?
> 
> 
> How on earth is the kernel supposed to know that for this one particular
> job you don't care if it takes 3 hours instead of 10 minutes, just because
> you don't want to spare enough preciousss RAM?

Maybe the kernel should be told by the apps exactly what they require in 
the way of memory and maybe how to slice up what the app gets for memory 
from the kernel.

This would not be the first time that applications had to specify such 
information.

That was what REGION= and other such parameters were all about in other 
operating systems.

Then the kernel would have free use of what was left until the next app 
started etc ....

Cheers,
   Dave
