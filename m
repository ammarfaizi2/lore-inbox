Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbRAEXjP>; Fri, 5 Jan 2001 18:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129895AbRAEXjG>; Fri, 5 Jan 2001 18:39:06 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:30343 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S129777AbRAEXi7>;
	Fri, 5 Jan 2001 18:38:59 -0500
Message-ID: <3A565B09.C7225703@pobox.com>
Date: Fri, 05 Jan 2001 15:38:49 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Nicolas Parpandet <nparpand@perinfo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel network problem ?
In-Reply-To: <000d01c07724$8fa531f0$8900030a@nicolasp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Parpandet wrote:

> Hi all,
>
> I'm testing 2.4 series for few weeks,
> even the last prerelease
>
> I've seen stranges things  :
>
> I cannot access to some ips adresses ! :
> in http or in smtp using "konqueror", "netscape",
> "mail",  "telnet 25".
>
> I cannot login to hotmail (in the web page:http)
> or send mail (smtp) to hotmail users (don't blame me !!)
> All the others network things works well, the network in general seems
> good only very few sites like hotmail doesn't works.

Do you have "explicit congestion notification" enabled?

If so,

echo "0" >  /proc/sys/net/ipv4/tcp_ecn

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
