Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262269AbSIZKTE>; Thu, 26 Sep 2002 06:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262272AbSIZKTE>; Thu, 26 Sep 2002 06:19:04 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:37105 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S262269AbSIZKTE>; Thu, 26 Sep 2002 06:19:04 -0400
Message-ID: <3D92E090.4030504@drugphish.ch>
Date: Thu, 26 Sep 2002 12:25:20 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, niv@us.ibm.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
References: <p73n0q5sib2.fsf@oldwotan.suse.de>	<20020925.172931.115908839.davem@redhat.com>	<3D92CCC5.5000206@drugphish.ch> <20020926.020602.75761707.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> About using syslog to record messages, that is doomed to failure,
> implement log messages via netlink and use that to log the events
> instead.

<maybe stupid thought>
Another thing would be to use netconsole to send event messages over the 
network to a central loghost. This would eliminate the buffer overwrite 
problem unless you sent more messages than the backlog queue is able to 
hold before the packets are being processed. But you could theoretically 
send 10 MB messages per seconds that could also be stored.
</maybe stupid thought>

I will shut up now as I do not want to waste your and the others 
precious time with my extensive schmoozing ;).

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

