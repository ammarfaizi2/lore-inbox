Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263496AbTC2TWe>; Sat, 29 Mar 2003 14:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263497AbTC2TWd>; Sat, 29 Mar 2003 14:22:33 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:36331 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S263496AbTC2TWd>;
	Sat, 29 Mar 2003 14:22:33 -0500
From: wind@cocodriloo.com
Date: Sat, 29 Mar 2003 20:33:56 +0100
To: linux-kernel@vger.kernel.org
Subject: [wind@cocodriloo.com: fairsched + O(1) scheduler]
Message-ID: <20030329193356.GB6709@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is a simple question... anyone working on integrating fairsched
with O(1) ?

I would like to try doing it, but I think it's better if I share
the work with others who are trying to do it.

For those that don√'t know, "fairsched"distributes evenly the CPU amongst
different users competing for it. Thus, on a non-fairsched kernel user A
running 4 CPU-hogs will get four times as much CPU as user B which
runs only 1 CPU-hog.

fairsched works by keeping stats of per-user CPU time and tries to balance
it so that no user can get all CPU.

I'm just starting to review the 2.4.19 implementation, which is based on
the classic O(n) scheduler, so any help on forward porting it to 2.5.66+
will be apreciated.


Greets, Antonio.

