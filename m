Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266131AbUF2WrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUF2WrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUF2WrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:47:16 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:47156 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266134AbUF2Wq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:46:58 -0400
Message-ID: <34041.192.168.1.9.1088549218.squirrel@192.168.1.9>
In-Reply-To: <freemail.20040529204757.69738@fm12.freemail.hu>
References: <20040629183847.GA9493@outpost.ds9a.nl>
    <freemail.20040529204757.69738@fm12.freemail.hu>
Date: Wed, 30 Jun 2004 00:46:58 +0200 (CEST)
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
From: "Redeeman" <redeeman@metanurb.dk>
To: "Debi Janos" <debi.janos@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Reply-To: redeeman@metanurb.dk
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> bert hubert <ahu@ds9a.nl> írta:
>
>> On Tue, Jun 29, 2004 at 08:04:46PM +0200, Debi Janos wrote:
>> > bert hubert <ahu@ds9a.nl> ?rta:
>
>> Suggestions:
>> 	1) turn off timestamps (echo 0 >
> /proc/sys/net/ipv4/tcp_timestamps)
>> 	2) set your MTU to 1000 or so (ifconfig eth0 mtu 1000)
>>
>> And try again.
>>
>> Interesting case!
>
> problem workarounded:
>
> sysctl -w net.ipv4.tcp_moderate_rcvbuf=0
> sysctl -w net.ipv4.tcp_default_win_scale=0
yep, this solves packages.gentoo.org..
but lkml.org is still broken for me.. i'd really like to know what this is
all about :>

> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


-- 


