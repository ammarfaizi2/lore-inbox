Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266112AbSIRLQO>; Wed, 18 Sep 2002 07:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbSIRLQO>; Wed, 18 Sep 2002 07:16:14 -0400
Received: from jalon.able.es ([212.97.163.2]:26832 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S266112AbSIRLQO>;
	Wed, 18 Sep 2002 07:16:14 -0400
Date: Wed, 18 Sep 2002 13:20:46 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG() triggered on SMP shutdown, cpu!=0
Message-ID: <20020918112046.GA1537@werewolf.able.es>
References: <20020918102029.GA1536@werewolf.able.es> <1032345705.20463.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1032345705.20463.73.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Sep 18, 2002 at 12:41:45 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.18 Alan Cox wrote:
>On Wed, 2002-09-18 at 11:20, J.A. Magallon wrote:
>> Hi all...
>> 
>> I am getting oopses on shutdown, 'cause this bug is popping:
>
>That doesnt suprise me. The code assumes the old scheduler and -aa has
>the O(1) scheduler. Grab the fix to that small piece of code from -ac,
>or I'm pretty sure from a newer Andrea tree
>

I took the chages to apm.c from -ac and it works ok now.
Latest -aa is 2.4.20-pre5-aa2 and does not include this.
I will send it to Andrea.

Thanks.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre7-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
