Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267514AbRHAQx3>; Wed, 1 Aug 2001 12:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267516AbRHAQxS>; Wed, 1 Aug 2001 12:53:18 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:62217 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267520AbRHAQxH>;
	Wed, 1 Aug 2001 12:53:07 -0400
Message-Id: <200107312253.CAA00475@mops.inr.ac.ru>
Subject: Re: Determining IP:port corresponding to an ICMP port unreachable
To: erikd@lithtech.COM (Erik De Bonte)
Date: Wed, 1 Aug 2001 02:53:01 -2000 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <AF020C5FC551DD43A4958A679EA16A1501349560@mailcluster.lith.com> from "Erik De Bonte" at Jul 31, 1 11:15:03 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> >From my original message: "I'm able to retrieve the IP via recvmsg with the
> MSG_ERRQUEUE flag (and the IP_RECVERR sockopt), but the port that it gives
> me is bogus."

Sigh, please, send sample yet. It works here by some strange reason,
apparently, my applet is buggy. :-)


> extract the port and give it to me?  It's obviously possible, since Winsock
> does it.**

Well, better ask those brave MS folks why they did this. :-) 

Actually, please, check this again: I was not aware that nt posix env
break bsd api in such wicked way. This can be useful as a strong argument
in some curcumstances.

Alexey
