Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135515AbRAQTMj>; Wed, 17 Jan 2001 14:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135611AbRAQTMT>; Wed, 17 Jan 2001 14:12:19 -0500
Received: from raven.toyota.com ([63.87.74.200]:20744 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S135584AbRAQTMO>;
	Wed, 17 Jan 2001 14:12:14 -0500
Message-ID: <3A65EE8B.9DCA3CEE@pobox.com>
Date: Wed, 17 Jan 2001 11:12:11 -0800
From: J Sloan <jjs@pobox.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre3-ll i686)
X-Accept-Language: en
MIME-Version: 1.0
To: snpe <snpe@infosky.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with networking in 2.4.0
In-Reply-To: <01011714061700.00939@spnew>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try this shot in the dark:

echo "0" > /proc/sys/net/ipv4/tcp_ecn

jjs

snpe wrote:

> Hello,
>
> I have got 2 Linux machine with kernel 2.4.0 i kernel 2.2.18.
> I am in Belgrade , Yugoslavia and I can't access to any hosts :
>
> for example, www.linux.co.yu (Island), www.skyrr.is, www.hotmail.com etc
>
> Access is ok with kernel 2.2 even in a case when machine with 2.4 kernel is
> masquerading host.
> It doesn't work with any port.
> Ping works.
>
> I think that these hosts are behind CISCO PIX firewall.
>
> I am not sure if it is related with seting kernel.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
