Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270177AbRHGKpJ>; Tue, 7 Aug 2001 06:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270178AbRHGKo7>; Tue, 7 Aug 2001 06:44:59 -0400
Received: from [194.92.3.7] ([194.92.3.7]:8848 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S270177AbRHGKol>;
	Tue, 7 Aug 2001 06:44:41 -0400
Date: Tue, 7 Aug 2001 12:44:13 +0200
From: Lech Szychowski <lech.szychowski@pse.pl>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tulip driver problem
Message-ID: <20010807124413.A14235@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010806100319.C833@cpe-24-221-152-185.az.sprintbbd.net> <200108062016.f76KGmG117015@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108062016.f76KGmG117015@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.20i
Organization: Polskie Sieci Elektroenergetyczne S.A.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> eth0: Setting half-duplex based on MII#1 link partner capability of 0021.
> NETDEV WATCHDOG: eth0: transmit timed out
> NETDEV WATCHDOG: eth0: transmit timed out
> NETDEV WATCHDOG: eth0: transmit timed out
> NETDEV WATCHDOG: eth0: transmit timed out

Does eth0 share IRQ with any other card? I got the very same messages
when one of my 4-way Adaptec (tulip based) ports got assigned the same
IRQ as my SCSI card (53c810a). BTW, that forced me to swich to using
de4x5 driver...

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
