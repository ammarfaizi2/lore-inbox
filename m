Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVCSFEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVCSFEU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 00:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVCSFEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 00:04:20 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:9943 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262406AbVCSFER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 00:04:17 -0500
Message-ID: <423BB299.4010906@colorfullife.com>
Date: Sat, 19 Mar 2005 06:03:21 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
References: <20050318002026.GA2693@us.ibm.com> <20050318091303.GB9188@elte.hu> <20050318092816.GA12032@elte.hu>
In-Reply-To: <20050318092816.GA12032@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>	read_lock(&rwlock);
>	...
>		read_lock(&rwlock);
>
>are still legal. (it's also done quite often.)
>
>  
>
How do you handle the write_lock_irq()/read_lock locks?
E.g. the tasklist_lock or the fasync_lock.

--
    Manfred
