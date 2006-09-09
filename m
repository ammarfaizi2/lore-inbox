Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWIIXah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWIIXah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 19:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWIIXag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 19:30:36 -0400
Received: from gw.goop.org ([64.81.55.164]:15758 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965013AbWIIXag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 19:30:36 -0400
Message-ID: <45034E97.9090109@goop.org>
Date: Sat, 09 Sep 2006 16:30:31 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386-pda updates
References: <45027822.2010906@goop.org> <20060909155257.GA50136@muc.de>
In-Reply-To: <20060909155257.GA50136@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> @@ -20,7 +22,14 @@ extern struct i386_pda _proxy_pda;
>> #define pda_to_op(op,field,val)					 \
>> 	do {								\
>> 		typedef typeof(_proxy_pda.field) T__;			\
>> +		if (0) { T__ tmp__; tmp__ = (val); }			\
>>     
>
> Merged into original patch
>   
BTW, do you mean you already had this in i386, or that you folded it 
into the existing patch?  I don't think I had sent out my version of 
this before.

    J
