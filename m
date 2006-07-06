Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWGFT2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWGFT2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWGFT2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:28:48 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:41955 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750703AbWGFT2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:28:47 -0400
Message-ID: <44AD644E.5070108@colorfullife.com>
Date: Thu, 06 Jul 2006 21:28:14 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ulrich Drepper <drepper@redhat.com>,
       Michael Kerrisk <mtk-manpages@gmx.net>, mtk-lkml@gmx.net,
       rlove@rlove.org, roland@redhat.com, eggert@cs.ucla.edu,
       paire@ri.silicomp.fr, tytso@mit.edu, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
Subject: Re: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com> <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com> <44AD5CB6.7000607@redhat.com> <44AD5E5C.6070703@colorfullife.com> <Pine.LNX.4.64.0607061217320.3869@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607061217320.3869@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Thu, 6 Jul 2006, Manfred Spraul wrote:
>  
>
>>Is it necessary that the futex syscall ignores SA_RESTART?
>>    
>>
>
>Very possibly. That was definitely the case for "select()" long ago.
>
>  
>
select uses ERESTARTSYS...

--
    Manfred

