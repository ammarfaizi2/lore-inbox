Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281458AbRLQQ4B>; Mon, 17 Dec 2001 11:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281483AbRLQQzv>; Mon, 17 Dec 2001 11:55:51 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:20497 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281458AbRLQQzr>;
	Mon, 17 Dec 2001 11:55:47 -0500
Date: Mon, 17 Dec 2001 14:55:01 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Sebastian@conectiva.com.br,
        =?iso-8859-1?Q?Dr=F6ge_=3Csebastian=2Edroege=40gmx=2Ede=3E?=@conectiva.com.br
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: your mail
Message-ID: <20011217145501.B1196@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Sebastian@conectiva.com.br,
	=?iso-8859-1?Q?Dr=F6ge_=3Csebastian=2Edroege?=@conectiva.com.br,
	=?iso-8859-1?B?QGdteC5kZT4=?=@conectiva.com.br,
	Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <20011217170740.74a1cb95.sebastian.droege@gmx.de> <Pine.LNX.4.33.0112171717010.28670-100000@Appserv.suse.de> <20011217175206.193d02e0.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011217175206.193d02e0.sebastian.droege@gmx.de>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 17, 2001 at 05:52:06PM +0100, Sebastian Dröge escreveu:
> PS: 2.5.1 (dj1 or not ;) has one problem more on my pc:
> INIT can't send the TERM signal to all processes...

see the kill(-1,sig) thread...

> Nothing happens... no error message no nothing
> SysRQ works
> I don't know when it went into 2.5 but I think it wasn't there in -pre10 (don't try -pre11)
> PPS: What the hell is APIC (no I don't mean ACPI)? ;) I've enabled it on my UP machine but don't know what it does...
> Does anyone have informations about it?

Advanced Programmable Interrupt Controller, found in SMP machines and in
some UP ones, for UP its shouldn't be enabled in most cases.

- Arnaldo
