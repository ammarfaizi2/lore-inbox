Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278086AbRJPEJQ>; Tue, 16 Oct 2001 00:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278519AbRJPEJF>; Tue, 16 Oct 2001 00:09:05 -0400
Received: from airtrout.tregar.com ([209.73.238.93]:4618 "HELO
	airtrout.tregar.com") by vger.kernel.org with SMTP
	id <S278086AbRJPEIt>; Tue, 16 Oct 2001 00:08:49 -0400
Date: Mon, 15 Oct 2001 23:58:03 -0400 (EDT)
From: Sam Tregar <sam@tregar.com>
X-X-Sender: <sam@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: APM suspend broken in 2.4.12
Message-ID: <Pine.LNX.4.33.0110152349350.10534-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.  I just upgraded from 2.4.9 to 2.4.12.  I chose the same kernel
APM options in 2.4.12 as I had in 2.4.9 - CONFIG_APM, CONFIG_APM_DO_ENABLE
and CONFIG_APM_CPU_IDLE.  When I try to suspend using my laptop's suspend
key nothing happens.  Trying "apm --suspend" results in "apm: Resource
temporarily unavailable".  Standby still works.

Searching through the archives I see that this problem has been reported
for 2.4.10.  The conversation seemed to die off after it was posited that
some non-APM driver was vetoing the suspend.  The suspects mentioned were
the keyboard driver or something called "A20".  Has anyone done any
further investigation?  Any suggestions as to how I might go about
tracking this down?

Thanks!
-sam


