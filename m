Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316644AbSGBGLY>; Tue, 2 Jul 2002 02:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSGBGLX>; Tue, 2 Jul 2002 02:11:23 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9993 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316644AbSGBGLW>; Tue, 2 Jul 2002 02:11:22 -0400
Message-Id: <200207020546.g625krT21284@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Bill Davidsen <davidsen@tmr.com>, willy tarreau <wtarreau@yahoo.fr>
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
Date: Tue, 2 Jul 2002 08:46:36 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Willy TARREAU <willy@w.ods.org>, willy@meta-x.org,
       linux-kernel@vger.kernel.org, Ronald.Wahl@informatik.tu-chemnitz.de
References: <Pine.LNX.3.96.1020701115336.23428B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020701115336.23428B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 July 2002 13:55, Bill Davidsen wrote:
> On Mon, 1 Jul 2002, [iso-8859-1] willy tarreau wrote:
> > Like I said above, I didn't insist on optimizations,
> > I prefered to get a clear code first. If I want to
> > optimize, I think most of this will be assembler.
>
> This sounds good, the idea is that it should work at all, clarity is good,
> I can't imagine anyone running this long term instead of building a
> compile with the right machine type.

I see a potential problem here: if someone is running such kernel
all the time, he can take huge performance penalty. 'Dunno why but on
my box mailer does not run. It _crawls_'.
Ordinary user may perceive it like 'Linux is slow'.

What can be done to prevent this? Printk can go unnoticed in the log,
as far as nothing actually breaks user won't look into the logs...

1.big red letters 'CMOV EMULATION' across the screen? :-)
2.Scroll lock LED inverted each time CMOV is triggered?
3.Printk at kernel init time:
  "Emergency rescue kernel with CMOV emulation: can be very slow,
	not for production use!" ?

Of course (1) is a joke.
--
vda
