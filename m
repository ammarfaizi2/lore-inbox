Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUFIVGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUFIVGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266179AbUFIVGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:06:17 -0400
Received: from nepa.nlc.no ([195.159.31.6]:65431 "HELO nepa.nlc.no")
	by vger.kernel.org with SMTP id S266192AbUFIVDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:03:06 -0400
Message-ID: <1701.83.109.60.63.1086814977.squirrel@nepa.nlc.no>
Date: Wed, 9 Jun 2004 23:02:57 +0200 (CEST)
Subject: timer + fpu stuff locks my console race
From: stian@nixia.no
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0-1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please keep me in CC as I'm not on the mailinglist. I'm currently on a
vaccation, so I can't hook my linux-box to the Internet, but I came across
a race condition in the "old" 2.4.26-rc1 vanilla kernel.

I'm doing some code tests when I came across problems with my program
locking my console (even X if I'm using a xterm).

I think first of all gcc triggers the problem, so the full report is here:
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=15905

For more details about versions and other information needed, please let
me know if needed. It triggers at every attempt at my box currently (and
I'm lacking Internet connection at the time-being on my machine).



Stian Skjelstad
