Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316970AbSGNRjN>; Sun, 14 Jul 2002 13:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSGNRjM>; Sun, 14 Jul 2002 13:39:12 -0400
Received: from [200.203.199.90] ([200.203.199.90]:63504 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S316970AbSGNRjL>; Sun, 14 Jul 2002 13:39:11 -0400
Date: Sun, 14 Jul 2002 14:42:00 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Christian Gennerat <xgen@free.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: hda: lost interrupt
Message-ID: <20020714174200.GC18731@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Christian Gennerat <xgen@free.fr>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D31B748.9070808@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D31B748.9070808@free.fr>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 14, 2002 at 07:39:20PM +0200, Christian Gennerat escreveu:
> I have this line in my /etc/rc.d/rc.local
> hdparm -c 1 -m 16 -S 6 /dev/hda

> with 2.4.18 kernel it works fine.
> with 2.5.25 I get "hda: lost interrupt" 30 seconds after.
> And reset, and fsck... every time

> What is new in 2.5.25 ?

What is _wrong_ in 2.5.25? is the right question, read the archives and,
from what bzolnier said, _don't_ use 2.5.25 vanilla with IDE.

- Arnaldo
