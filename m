Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274864AbRIUWyG>; Fri, 21 Sep 2001 18:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274865AbRIUWx4>; Fri, 21 Sep 2001 18:53:56 -0400
Received: from c007-h000.c007.snv.cp.net ([209.228.33.206]:18129 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S274864AbRIUWxp>;
	Fri, 21 Sep 2001 18:53:45 -0400
X-Sent: 21 Sep 2001 22:53:56 GMT
Content-Type: text/plain; charset=US-ASCII
From: Derek Gladding <derek_gladding@altavista.net>
Reply-To: derek_gladding@altavista.net
To: linux-kernel@vger.kernel.org
Subject: Re: AIC-7XXX driver problems with 2.4.9 and L440GX+
Date: Fri, 21 Sep 2001 15:51:14 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BABA9F4.3677E423@timesn.com>
In-Reply-To: <3BABA9F4.3677E423@timesn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010921225353Z274864-760+15078@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 September 2001 01:58 pm, Ray Bryant wrote:
> The AIC-7XXX version 6.2.1 driver hangs at startup under 2.4.x  (we've
> tried
> 2.4.2-2 (RH 7.1), 2.4.5, and 2.4.9).

[snip]

> These same machines worked fine with 2.2.18 from www.kernel.org and
> 2.2.19 from RedHat.  Any suggestions?
>
> Machine is an Intel L440GX+ 700 MHZ PIII 2GB RAM
> Adapter is Adaptec AIX-7896 Bios level is v2.20.S1B1
> Disks are QUANTUM ATLS TY09TL
> Machine bios is Phoenix 4.0 Release 6.0


I had something similar on my dev box (2.4.[789] / Dual PIII-750 / Via / 1.5G 
/ Adaptec 2940 / three striped IBM DCHS-09Y 9.1G) and found that compiling 
the aic7xxx driver with TCQ disabled got round the problem. A far from 
perfect solution, I know, but it may get you up and running and maybe
provide some more clues as to what is happening.

- Derek


