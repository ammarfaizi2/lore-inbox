Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTH2FlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 01:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTH2FlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 01:41:05 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:55458 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262461AbTH2FlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 01:41:03 -0400
Message-ID: <3F4EE764.6000101@colorfullife.com>
Date: Fri, 29 Aug 2003 07:40:52 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: vmalloc allocations in ipc needs smp initialized (and vm must
 be allowed to schedule in 2.6)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea wrote:

>the patch is obviously safe, since no piece of kernel (especially the
>code in the check_bugs and smp_init paths ;) calls into the ipc
>subsystem.
>  
>
What about making ipc_init a proper initcall? I think that's better than 
moving the ipc_init call around.

--
    Manfred

