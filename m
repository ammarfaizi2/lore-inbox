Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280714AbRKGAVy>; Tue, 6 Nov 2001 19:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280713AbRKGAVe>; Tue, 6 Nov 2001 19:21:34 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:19974
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S280709AbRKGAVU>; Tue, 6 Nov 2001 19:21:20 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200111062358.fA6Nwfw05321@www.hockin.org>
Subject: Re: [PATCH] lp.c, eexpress.c jiffies cleanup
To: adilger@turbolabs.com (Andreas Dilger)
Date: Tue, 6 Nov 2001 15:58:41 -0800 (PST)
Cc: philb@gnu.org (Philip Blundell),
        tim@physik3.uni-rostock.de (Tim Schmielau),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011106171023.A5922@lynx.no> from "Andreas Dilger" at Nov 06, 2001 05:10:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> afterwards.  Sucking all CPU for 20 seconds and locking everything else
> out isn't an acceptable method IMHO.


There are drivers that do this WITH INTERRUPTS OFF.  Some systems (e.g.
Cobalt) have short-interval watchdog timers, and when someone uses one of
these drivers, they just see spontaneous reboots.  Ick.


