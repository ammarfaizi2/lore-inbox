Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262263AbSIZJSE>; Thu, 26 Sep 2002 05:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262264AbSIZJSE>; Thu, 26 Sep 2002 05:18:04 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:65259 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S262263AbSIZJSD>; Thu, 26 Sep 2002 05:18:03 -0400
Message-ID: <3D92D243.6060808@drugphish.ch>
Date: Thu, 26 Sep 2002 11:24:19 +0200
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

> I'm not talking about cpu second level cache, I'm talking about
> a second level lookup table that backs up a front end routing
> hash.  A software data structure.

Doh! Sorry for my confusion, I guess I wasn't reading your posting too 
carefully. I understand the software architecture part now. Nevertheless 
one day or another you will need to face the caching issue too unless 
your data structure will always fit entirely into the cache or am I 
completely off track again?

> You are talking about a lot of independant things, but I'm going
> to defer my contributions until we have actual code people can
> start plugging netfilter into if they want.

Fair enough. I'm looking forward to seeing this framework. Any release 
schedules or rough plans?

> About using syslog to record messages, that is doomed to failure,
> implement log messages via netlink and use that to log the events
> instead.

Yes, we're doing tests in this field now (as with evlog) but as it seems 
from preliminary testing netlink transportation of binary data is not 
100% reliable either. However, I will refrain from further posting 
assumptions until we've done our tests and until we can post useful 
results and facts in this field.

Thanks and cheers,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

