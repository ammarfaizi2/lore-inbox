Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTKHCPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 21:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTKHCPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 21:15:05 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:12718 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261298AbTKHCPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 21:15:02 -0500
Message-ID: <3FAC51A1.30307@cyberone.com.au>
Date: Sat, 08 Nov 2003 13:14:57 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <20031106130030.GC1145@suse.de> <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de> <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de> <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de> <3FAA5043.8060907@gmx.de> <20031106134713.GA798@suse.de> <3FAA5397.6010702@gmx.de> <20031106135134.GA1194@suse.de> <3FAA5CCB.5030902@gmx.de> <3FAB0754.2040209@cyberone.com.au> <3FAB7F94.7050504@gmx.de> <3FAB82A2.4070907@cyberone.com.au> <3FAB8428.7090307@gmx.de> <3FAB870D.1050003@cyberone.com.au> <3FAB95B9.3020601@gmx.de> <3FAB9817.5020502@cyberone.com.au> <3FAB9C2B.2040907@gmx.de> <3FAB9F97.6050706@cyberone.com.au> <3FABA364.9000404@gmx.de> <3FABA5A7.904@cyberone.com.au> <3FABA6EF.90207@gmx.de> <3FABA788.1080000@cyberone.com.au> <3FABAB5B.5090105@gmx.de> <3FABAE0B.6020601@cyberone.com.au> <3FABB08B.3080006@gmx.de> <3FABB571.6070804@cyberone.com.au> <3FABBEC7.4010702@gmx.de>
In-Reply-To: <3FABBEC7.4010702@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Prakash K. Cheemplavam wrote:

>
>> Oh ok. Well whenever you get a chance to... Sorry that last patch
>> I sent was empty. Here is the correct one for when you get time.
>
>
> Yeah, runs nicely. (dmesg is quiet, as well.) Seems like it was only a 
> minor issue in mm2, lloking at the patch...Very well.


Thanks a lot for your patience Prakash. Looks like its fixed then.
Yeah it was a pretty minor problem: you were triggering lots of warnings,
but if you can't see them in dmesg, maybe /proc/sys/kernel/printk is
configured to not show them.

Have a look at Documentation/sysctl/kernel.txt if you'd like to fix that
up. Thanks again.

Nick

