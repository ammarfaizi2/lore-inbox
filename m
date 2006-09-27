Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWI0Q7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWI0Q7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWI0Q7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:59:46 -0400
Received: from gw.goop.org ([64.81.55.164]:54190 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030244AbWI0Q7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:59:45 -0400
Message-ID: <451AAE0A.4010704@goop.org>
Date: Wed, 27 Sep 2006 09:59:54 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: revised pda patches
References: <4518D273.2030103@goop.org> <20060927113136.GA80066@muc.de>
In-Reply-To: <20060927113136.GA80066@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I added them now, thanks.
>
> At least one seemed to assume that asm-offsets.c already has entries
> for all the registers, which wasn't the case. I fixed that up from
> the patch context, but some double checking might be useful.
>   

Eh?  They patch+compile cleanly against your patch queue of the other 
day.  -use-gs adds PT_GS to asm-offsets, assuming that 
"i386-pda-asm-offsets" has already been applied.  Did you accidentally 
remove that from your queue too; it was just before the old 
"i386-pda-basics"?

    J
