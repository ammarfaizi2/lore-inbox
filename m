Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268174AbUHTPQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268174AbUHTPQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268183AbUHTPGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:06:42 -0400
Received: from czf-prosek6.supernetwork.cz ([81.31.22.46]:1920 "EHLO
	noodles.netw") by vger.kernel.org with ESMTP id S267358AbUHTPCU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:02:20 -0400
From: Jan Spitalnik <jan@spitalnik.net>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: 2.6.8.1 slews system clock
Date: Fri, 20 Aug 2004 17:02:01 +0200
User-Agent: KMail/1.7
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408201527.07126.jan@spitalnik.net> <Pine.LNX.4.53.0408201601200.12519@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0408201601200.12519@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408201702.01287.jan@spitalnik.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne pá 20. srpna 2004 16:02 Tim Schmielau napsal(a):
> On Fri, 20 Aug 2004, Jan Spitalnik wrote:
> > after updating kernel to 2.6.8.1 the system clock slews by 1 second every
> > 10 seconds into future. I tried turning off ACPI, but that had no effect.
> >
> > root@largo:~# ntpdate tik.cesnet.cz;sleep 10;ntpdate tik.cesnet.cz
> > 20 Aug 13:55:01 ntpdate[5315]: step time server 195.113.144.201 offset
> > -24.488611 sec
> > 20 Aug 13:55:13 ntpdate[5321]: step time server 195.113.144.201 offset
> > -1.042110 sec
> >
> > on second machine the effect is opposite, ie the clock slews backwards.
> > Any ideas?
>
> Which was the last kernel that worked?

2.6.7 didn't exhibit this problem. I will test 2.6.8-rc's to find which one 
caused this regression. 

-- 
Jan Spitalnik
jan@spitalnik.net

