Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264221AbTEGU0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbTEGU0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:26:11 -0400
Received: from watch.techsource.com ([209.208.48.130]:32421 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S264221AbTEGU0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:26:10 -0400
Message-ID: <3EB96FB2.2020401@techsource.com>
Date: Wed, 07 May 2003 16:42:26 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Roland Dreier <roland@topspin.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com> <Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com> <Pine.LNX.4.53.0305071523010.13724@chaos> <52n0hyo85x.fsf@topspin.com> <Pine.LNX.4.53.0305071547060.13869@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:
> 
> When a caller executes int 0x80, this is a software interrupt,
> called a 'trap'. It enters the trap handler on the kernel stack,
> with the segment selectors set up as defined for that trap-handler.
> It happens because software told hardware what to do ahead of time.
> Software doesn't do it during the trap event. In the trap handler,
> no context switch normally occurs. 

On typical processors, when one gets an interrupt, the current program 
counter and processor state flags are pushed onto a stack.  Which stack 
gets used for this?


