Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264551AbUESU7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbUESU7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 16:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbUESU7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 16:59:45 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:25258 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264551AbUESU7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 16:59:43 -0400
Message-ID: <40ABCA30.8010806@colorfullife.com>
Date: Wed, 19 May 2004 22:57:20 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaco Kroon <jkroon@cs.up.ac.za>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at slab.c:1930
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>The following OOPS occured this morning.  This is on a dual CPU machine, 
>there were two oopses, unfortunately the other scrolled off the screen 
>but the process was lockd (nfs related afaik).
>  
>
Unfortunately the first one is the important one :-(

>Here is the oops (written off and typed up), unfortunately I don't know 
>how to convert this to nicely readable symbols ...
>
>Kernel BUG at slab.c:1930
>
That's an oops caused by a consistency check while printing 
/proc/slabinfo. Probably a side effect of the first oops.

--
    Manfred


