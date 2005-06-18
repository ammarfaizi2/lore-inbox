Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVFRNo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVFRNo6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 09:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVFRNo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 09:44:58 -0400
Received: from mail.linicks.net ([217.204.244.146]:39442 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262113AbVFRNo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 09:44:56 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Date: Sat, 18 Jun 2005 14:44:52 +0100
User-Agent: KMail/1.8.1
References: <200506181332.25287.nick@linicks.net> <200506181403.41212.s0348365@sms.ed.ac.uk>
In-Reply-To: <200506181403.41212.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506181444.52670.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 June 2005 14:03, Alistair John Strachan wrote:
> > New 2.6.12 build hangs at initialising udev dynamic device directory on
> > boot. I used make oldconfig from 2.6.11.12, and all the new changes I
> > selected N, all bar nvidia FB support (I built several times, as I have a
> > GeForce4 card, so suspected the nvidia FB support at first and turned
> > off).
> >
> > 2.6.11.12 works perfect.
> >
> > I have just spent an hour or so investigating, but I am none the wiser.
> >
> > Ideas what could be causing this?
>
> I had this problem because I was running an ancient version of udev (0.34,
> versus 0.58, at the time..). Try upgrading udev if it's out of date.

Thanks, that worked :-)

Strange how the mind works.  I thought about that, but only for a nanosecond.  
After reading the changelog, I was convinced (or didn't think no more about) 
as the udev code stuff hadn't changed from 2.6.11.12 -> 2.6.12.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
