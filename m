Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSHZLWL>; Mon, 26 Aug 2002 07:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSHZLWL>; Mon, 26 Aug 2002 07:22:11 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:9228 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S318047AbSHZLWK>;
	Mon, 26 Aug 2002 07:22:10 -0400
Message-ID: <3D6A080B.6010606@namesys.com>
Date: Mon, 26 Aug 2002 14:50:51 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: J Sloan <jjs@lexus.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] sendmail kernel tuning params
References: <3D66BA7C.6000503@lexus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:

> Hi All,
>
> We're setting up some new sendmail boxes
> which we intend to keep pretty busy, on the
> order of millions of messages/mo anyway.
>
> The systems are dual processor Dell 2450
> w/ perc raid running Red Hat 7.3 -
>
> Following the best practices from the sendmail
> BOF at Linux World, we've installed sendmail
> 8.12.5, and have created 16 queues on reiserfs
> partitions which are mounted -notail, -noatime.
>
> Do any sendmail/kernel gurus have words of
> wisdom on recommended kernel sysctl params
> for such a beast? I mean they look good, but
> I'd like to make sure I'm getting the best possible
> sendmail performance and not missing anything.
>
> The sendmail guy at the BOF lost his laptop or
> something and didn't have the recommended
> params handy -  I haven't been able to raise
> him since then either.
>
> Any pointers, or whacks with clue-by-fours are
> gladly accepted.
>
> Best Regards,
>
> Joe
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
You'll want the data logging patches from Chris (mason@suse.de).

Hans


