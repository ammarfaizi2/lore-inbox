Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTIMTit (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTIMTit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:38:49 -0400
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:3766 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262160AbTIMTiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:38:46 -0400
Message-ID: <3F637245.9070009@abcpages.com>
Date: Sat, 13 Sep 2003 21:38:45 +0200
From: Nicolae Mihalache <mache@abcpages.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test4 problems: suspend and touchpad
References: <Pine.LNX.4.33.0309121519420.984-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0309121519420.984-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:

>>2. suspend/resume. With version 2.6test2+acpi patch both swsusp and 
>>"echo 3 >/proc/acpi/sleep" worked, being able to somehow successfully 
>>resume. In version 2.6test4 there is no /proc/acpi/sleep and swsusp 
>>hangs somwhere during an IDE call (I can hand-copy the trace if needed).
>>    
>>
>
>Would you please try the latest -mm patch (2.6.0-test5-mm1, I believe) and 
>report your findings? 
>  
>

Well, the 2.6.0-test5-mm1 does not compile on my system (SuSE 8.2, gcc 
version 3.3 20030226 (prerelease) ):

mm/slab.c: In function `ptrinfo':
mm/slab.c:2792: warning: comparison between signed and unsigned
mm/slab.c:2798: warning: implicit declaration of function `dbg_redzone1'
mm/slab.c:2798: error: invalid type argument of `unary *'
mm/slab.c:2798: warning: implicit declaration of function `dbg_redzone2'
mm/slab.c:2798: error: invalid type argument of `unary *'
mm/slab.c:2801: warning: implicit declaration of function `dbg_userword'
mm/slab.c:2801: error: invalid type argument of `unary *'
make[1]: *** [mm/slab.o] Error 1


thanks,
mache

