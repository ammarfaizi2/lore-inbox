Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSIZUo4>; Thu, 26 Sep 2002 16:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbSIZUo4>; Thu, 26 Sep 2002 16:44:56 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:4313 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S261492AbSIZUoy>; Thu, 26 Sep 2002 16:44:54 -0400
Message-ID: <3D93733D.6050905@drugphish.ch>
Date: Thu, 26 Sep 2002 22:51:09 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org, jamal <hadi@cyberus.ca>
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
References: <Mutt.LNX.4.44.0209270051180.12285-100000@blackbird.intercode.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Non-blocking netlink delivery is reliable, although you can overrun the 
> userspace socket buffer (this can be detected, however).  The fundamental 
> issue remains: sending more data to userspace than can be handled.

Agreed.

> A truly reliable transport would also involve an ack based protocol .  
> Under certain circumstances (e.g. log every forwarded packet for audit
> purposes), packets would need to be dropped if the logging mechanism
> became overloaded.  This would in turn involve some kind of queuing
> mechanism and introduce a new set of performance problems.  Reliable
> logging is a challenging problem area in general, probably better suited
> to dedicated hardware environments where the software can be tuned to
> known system capabilities.

Thanks. I think we'll find a solution that will suit us best and if we 
have something we let the community know.

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

