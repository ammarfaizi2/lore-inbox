Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUFOFAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUFOFAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 01:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUFOFAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 01:00:32 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:5257 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264443AbUFOFAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 01:00:31 -0400
Message-ID: <40CE824D.9020300@colorfullife.com>
Date: Tue, 15 Jun 2004 06:59:57 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "pj () sgi ! com" <"pj () sgi ! com"@dbl.q-ag.de>
CC: linux-kernel@vger.kernel.org, lse-tech <lse-tech@lists.sourceforge.net>,
       Andi Kleen <ak@muc.de>, Anton Blanchard <anton@samba.org>
Subject: Re: NUMA API observations
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>> I will probably make it loop and double the buffer until EINVAL
>> ends or it passes a page and add a nasty comment.
>
>I agree that a loop is needed.  And yes someone didn't do a very
>good job of designing this interface.
>
>  
>
What about fixing the interface instead? For example if user_mask_ptr 
NULL, then sys_sched_{get,set}affinity return the bitmap size.

--
    Manfred
