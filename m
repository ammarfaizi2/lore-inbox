Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280114AbRLQObQ>; Mon, 17 Dec 2001 09:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279307AbRLQObG>; Mon, 17 Dec 2001 09:31:06 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:26844 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S279556AbRLQOaw>; Mon, 17 Dec 2001 09:30:52 -0500
cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Date: Mon, 17 Dec 2001 15:30:07 +0100 (CET)
From: Oktay Akbal <oktay.akbal@s-tec.de>
In-Reply-To: <20011217141649.2ee44a10.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.43.0112171528160.2595-100000@omega.hbh.net>
MIME-Version: 1.0
Subject: Re: Problem with kernel nfs server in 2.4.17-rc1
To: Stephan von Krawczynski <skraw@ithnet.com>
X-AntiVirus: OK! AvMailGate Version 6.11.0.6
	 at mail has not found any known virus in this email.
X-X-Sender: oktay@omega.hbh.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that this problems exists. We are having this
Problem too. I am quite sure that this is not new in 2.4.17-preX.
Changed to UserSpace-nfs for now.

Oktay

On Mon, 17 Dec 2001, Stephan von Krawczynski wrote:

> Hello all,
> 
> I run constantly in a problem with knfsd (or related) that looks like this:
> After several hours clients cannot mount via nfs any more, they get:
> 
> db:/usr/src/packages/SOURCES # mount /backup
> mount: admin:/p2/backup/db failed, reason given by server: Permission denied
> 
> On the server I get:
> 
> Dec 17 14:09:54 admin rpc.mountd: getfh failed: Operation not permitted 
> 
> This issue can always be solved by simply restarting the kernel nfs server.
> Does this sound familiar to anybody? I tend to believe this is yet another
> issue with knfsd getting into troubles with failed allocs. I can test whatever,
> if someone tells me how and what.
> 
> Regards,
> Stephan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Oktay Akbal
S-Tec Datenverarbeitung GmbH
Feuerbachstr. 8
68163 Mannheim 
Tel: 0621-4185070
Fax: 0621-4185071

