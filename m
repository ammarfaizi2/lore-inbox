Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319341AbSHVNnk>; Thu, 22 Aug 2002 09:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319342AbSHVNnj>; Thu, 22 Aug 2002 09:43:39 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25348 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S319341AbSHVNnj>; Thu, 22 Aug 2002 09:43:39 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: IDE-flash device and hard disk on same controller
Date: 22 Aug 2002 13:41:24 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <ak2pm4$6dv$1@gatekeeper.tmr.com>
References: <A9713061F01AD411B0F700D0B746CA6802FC1464@vacho6misge.cho.ge.com>
X-Trace: gatekeeper.tmr.com 1030023684 6591 192.168.12.62 (22 Aug 2002 13:41:24 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <A9713061F01AD411B0F700D0B746CA6802FC1464@vacho6misge.cho.ge.com>,
Heater, Daniel (IndSys, GEFanuc, VMIC) <Daniel.Heater@gefanuc.com> wrote:

| OK. hdc=flash works where hdc=hard drive and hdd=CompactFlash.
| 
| Thanks Padraig.
| 
| I guess it's 6 of one, half-dozen the other, but telling the kernel that my
| hard drive is a flash drive just makes me feel squidgy!  I'm still inclined
| to suggest that the test that _prevents_ hard drive + CF configuration is no
| longer appropriate now that _some_ (most??) hardware vendors have figured
| out how to get ide-flash devices to work without "hanging" when no second
| device is present. Users with incompatible hardware can still prevent the
| long system hang by using hdx=none.

I think that traditionally people with broken hardware have been the
ones to use parameters to warn the kernel about them. I certainly have
run some ill-behaved hardware that way ;-) Since there is now and will
be in the future more correct systems than broken, it would seem that
the default would be to work with correct systems.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
