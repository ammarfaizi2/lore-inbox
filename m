Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318242AbSIOUSl>; Sun, 15 Sep 2002 16:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSIOUSk>; Sun, 15 Sep 2002 16:18:40 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:8428 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S318242AbSIOUSk>;
	Sun, 15 Sep 2002 16:18:40 -0400
Date: Sun, 15 Sep 2002 16:16:13 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <todd-lkml@osogrande.com>,
       <tcw@tempest.prismnet.com>, <netdev@oss.sgi.com>, <pfeather@cs.unm.edu>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <20020913.150439.27187393.davem@redhat.com>
Message-ID: <Pine.GSO.4.30.0209151053530.22001-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



10 gige becomes more of an interesting beast. Not sure if we would see
servers with 10gige real soon now. Your proposal does make sense although
compute power would still be a player. I think the key would be
parallelization;
Now if it wasnt for the stupid way TCP options were designed
you could easily do remote DMA instead. Would be relatively easy to add
NIC support for that. Maybe SCTP would save us ;-> however, if history
could be used to predict the future, i think TCP will continue to be
"hacked" and fit the throughput requirements so no chance for SCTP to be
a big player i am afraid .

cheers,
jamal

On Fri, 13 Sep 2002, David S. Miller wrote:

>    From: todd-lkml@osogrande.com
>    Date: Fri, 13 Sep 2002 15:59:15 -0600 (MDT)
>
>    not sure i understand what you're proposing
>
> Cards in the future at 10gbit and faster are going to provide
> facilities by which:
>
> 1) You register a IPV4 src_addr/dst_addr TCP src_port/dst_port cookie
>    with the hardware when TCP connections are openned.
>

[..]



