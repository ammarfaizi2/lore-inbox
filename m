Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbTDWBnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 21:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263929AbTDWBnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 21:43:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28577 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263928AbTDWBnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 21:43:05 -0400
Message-ID: <1491.4.64.197.106.1051062911.squirrel@fire.osdl.org>
In-Reply-To: <20030423012903.GI1249@Master.Bellsouth.net>
References: <000501c3090c$71683c60$0200a8c0@satellite> 
     <Pine.LNX.4.53.0304221649050.17809@chaos> 
     <1051053106.710.4.camel@teapot.felipe-alfaro.com> 
     <20030423012903.GI1249@Master.Bellsouth.net>
Date: Tue, 22 Apr 2003 18:55:11 -0700 (PDT)
Subject: Re: 2.5 kernel hangs system
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Murray J. Root" <murrayr@brain.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.0-1_kees1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Apr 23, 2003 at 01:11:46AM +0200, Felipe Alfaro Solana wrote:
>> On Tue, 2003-04-22 at 23:00, Richard B. Johnson wrote:
>> > First, I don't understand how as you say, "suggestions are
>> > desperately needed" on a developmental kernel. These things are
>> > not known to work on all configurations and some information like
>> > "It gives me hex codes..." is worthless. Please write down
>> > these "hex-codes" and, after booting a version the works, run them
>> > through ksymoops. If you don't know what that is:
>>
>> ksymoops? I thought 2.5 kernels didn't need ksymoops anymore and that
>> function names were automatically "guessed" in call stack traces.
>>
>
> IFF you use "include symbols" when building you shouldn't need ksymoops.
> IMO, if you're using 2.5.x you really should include the symbols - chances
> are you'll need em.

Maybe we are reading this differently, but it sounded to me like the
original system hang never reached the kernel | system log and that
some hex codes were the only clues.  In that case, pushing them thru
ksymoops does still make some sense, doesn't it?
How else would you determine where the hang occurred?

~Randy

