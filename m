Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSIZURJ>; Thu, 26 Sep 2002 16:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSIZURJ>; Thu, 26 Sep 2002 16:17:09 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:36078 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S261472AbSIZURH>; Thu, 26 Sep 2002 16:17:07 -0400
Message-ID: <3D936CB9.1040706@drugphish.ch>
Date: Thu, 26 Sep 2002 22:23:21 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
Cc: niv@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
References: <Pine.GSO.4.30.0209260739030.29224-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jamal,

[took out AK und DaveM since I know they both read netdev and this reply 
is not really of any relevance to them]

> It would be nice if people would start ccing networking related
> discussions to netdev. I missed the first part of the discussion
> but i take it the NF-HIPAC posted a patch.. BTW, I emailed the authors

Yes, your assumption is correct and sorry for missing the cc once again.

> when i read the paper but never heard back.
> What i wanted the authors was to compare against one of the tc
> classifiers not iptables.

I will contact you privately on this issue since I'm about to conduct 
tests this weekend.

> I hacked some code using the traffic control framework around OLS time;
> there are a lot of ideas i havent incorporated yet. Too many hacks, too
> little time ;-> I think this is what i may have showed Roberto on my
> laptop over a drink.

Exactly (even wearing a netfilter T-shirt).

> I probably wouldnt have put this code out if my complaints about
> netfilter werent ignored.
> And you know what happens when you start writting poetry, I ended worrying
> more than just about the performance problems of iptables; for example
> the code i have now makes it easy to extend the path a packet takes using
> simple policies.

Great, I remember some of your postings about the netfilter framework.

> The code i have is based around tc framework. One thing i liked about
> netfilter is the idea of targets being separate modules; so the code i
> have infact makes uses of netfilter targets.
> I plan on revisiting this code at some point, maybe this weekend now that
> i am reminded of it ;->

Excellent, this could make it into my test suites as well.

> Take a look:
> http://www.cyberus.ca/~hadi/patches/action.DESCRIPTION

I did, I simply didn't find the time to do it.

> Agreed, you need a netlink to syslog converter.
> Netlink is king -- all the policies in the above code are netlink
> controlled. All events are also netlink transported. You dont have to send
> every little message you see; netlink allows you to batch and you could
> easily do a nagle like algorithm. Next steps are a distributed version
> of netlink..

Is there a code architecture draft somewhere?

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

