Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270183AbTGZQ1a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270185AbTGZQ1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:27:30 -0400
Received: from dm4-160.slc.aros.net ([66.219.220.160]:9860 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S270183AbTGZQ13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:27:29 -0400
Message-ID: <3F22AF7E.1080601@aros.net>
Date: Sat, 26 Jul 2003 10:42:38 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307261142.43277.m.c.p@wolk-project.de> <200307270047.54349.kernel@kolivas.org>
In-Reply-To: <200307270047.54349.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>. . .
>Actually this is not strange to me. It has become obvious that the problems 
>with interactivity that have evolved in 2.5 are not scheduler related. Just 
>try plugging in all the old 2.4 O(1) scheduler settings into the current 
>scheduler and you will see that it still performs badly. What exactly is the 
>cause is a mystery but seems to be more a combination of factors with a 
>careful look at the way the vm behaves being part of that. . . .
>
Any chance that the problem may be due to the block layer system (and 
block driver(s)) getting more cycles than it should? Particularly with 
the out-of-band like work queue scheduling? That would at least explain 
the scheduling oddities I'm seeing with 2.6.0-test1 after a minute of so 
of intense I/O.

