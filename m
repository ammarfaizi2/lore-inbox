Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWC1Lhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWC1Lhf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 06:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWC1Lhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 06:37:35 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:18844 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932199AbWC1Lhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 06:37:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2gQiUMB+uvCAGDazpU4JljsFdx8oGhtjGO0HXRKSlSq3UkrP7TyP5iz8sXYNl+rrkveRaG7AUNTHOntCTGXQJzVbkXOfN8s3PhRuUL4wZbb1abVFJL0nKRHMVAOhF1QgoANPx5vL5XXqexg6q7iUn/qDHzjhlgRi/YUyhfhz1BA=  ;
Message-ID: <4428FEA5.9020808@yahoo.com.au>
Date: Tue, 28 Mar 2006 19:15:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <4428FB90.5000601@sw.ru>
In-Reply-To: <4428FB90.5000601@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> 
> Nick, will be glad to shed some light on it.
> 

Thanks very much Kirill.

I don't think I'm qualified to make any decisions about this,
so I don't want to detract from the real discussions, but I
just had a couple more questions:

> First of all, what it does which low level virtualization can't:
> - it allows to run 100 containers on 1GB RAM
>   (it is called containers, VE - Virtual Environments,
>    VPS - Virtual Private Servers).
> - it has no much overhead (<1-2%), which is unavoidable with hardware
>   virtualization. For example, Xen has >20% overhead on disk I/O.

Are any future hardware solutions likely to improve these problems?

> 
> OS kernel virtualization
> ~~~~~~~~~~~~~~~~~~~~~~~~

Is this considered secure enough that multiple untrusted VEs are run
on production systems?

What kind of users want this, who can't use alternatives like real
VMs?

> Summary of previous discussions on LKML
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Have their been any discussions between the groups pushing this
virtualization, and important kernel developers who are not part of
a virtualization effort? Ie. is there any consensus about the
future of these patches?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
