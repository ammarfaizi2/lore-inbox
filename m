Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135661AbRDXOv3>; Tue, 24 Apr 2001 10:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135660AbRDXOvT>; Tue, 24 Apr 2001 10:51:19 -0400
Received: from algernon.satimex.tvnet.hu ([195.38.110.113]:37650 "EHLO
	zeus.suselinux.hu") by vger.kernel.org with ESMTP
	id <S135661AbRDXOvE> convert rfc822-to-8bit; Tue, 24 Apr 2001 10:51:04 -0400
Date: Tue, 24 Apr 2001 16:49:57 +0200 (CEST)
From: Pjotr Kourzanoff <pjotr@suselinux.hu>
To: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <20010424163009.A7197@vega.digitel2002.hu>
Message-ID: <Pine.LNX.4.31.0104241643400.17653-100000@zeus.suselinux.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001, [iso-8859-2] Gábor Lénárt wrote:
>
> Or even without xinetd. Just use local port forwarding eg 2525 -> 25, and

  This is more like 25 -> 2525 :-)

> use port 2525 as SMTP port in your MTA. I've succeed to setup such a
> configuration.

  This requires you to ensure that your MTA is started first on that
  port...Might be difficult to achieve reliably in an automatic way
  without root privileges :-(

  mailuser@foo% /etc/rc.d/init.d/sendmail stop
  badguy@foo% ./suck 2525
  mailuser@foo% /etc/rc.d/init.d/sendmail start
  ...



