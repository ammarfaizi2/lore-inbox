Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269531AbUIZNnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269531AbUIZNnt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 09:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269534AbUIZNnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 09:43:49 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:55105 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269531AbUIZNnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 09:43:46 -0400
Message-ID: <33089.192.168.1.5.1096206148.squirrel@192.168.1.5>
In-Reply-To: <1096156450.3697.19.camel@krustophenia.net>
References: <20040903120957.00665413@mango.fruits.de> 
    <20040925203841.GB28001@elte.hu>
    <1096144856.3697.6.camel@krustophenia.net> 
    <200409252250.53703.baldrick@free.fr>
    <1096156450.3697.19.camel@krustophenia.net>
Date: Sun, 26 Sep 2004 14:42:28 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "Duncan Sands" <baldrick@free.fr>, "Ingo Molnar" <mingo@elte.hu>,
       "Florian Schmidt" <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 26 Sep 2004 13:43:41.0033 (UTC) FILETIME=[D54BED90:01C4A3CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>
> You know, this actually seems like an easier process than the serial
> console.  Is there any good reason this isn't the "recommended" way to
> diagnose lockups?  Unless they used to work at a telco ;-), most users
> are more likely to have an ethernet crossover cable handy than a serial
> cable.
>
> Here's the netconsole mini-mini HOWTO.
>
> load the module like:
>     insmod netconsole \
>     netconsole=source-port@source-ip/net-interface,dest-port@dest-ip/MAC-address
>
> for example:
>     modprobe netconsole \
>     netconsole=1234@69.44.153.169/eth0,4567@64.81.245.32/00:0A:8A:05:3D:80
>
> then connect the other machine and run:
>     netcat -u -l -p dest-port
>
> to watch the output.
>

Thanks Lee.

I have tested this netconsole stuff and it seems to work pretty well.
Already sent some results to alsa-devel bugtracker on the respective bug
entry.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

