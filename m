Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSFXBdC>; Sun, 23 Jun 2002 21:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317219AbSFXBdB>; Sun, 23 Jun 2002 21:33:01 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:4603 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S317217AbSFXBdA>; Sun, 23 Jun 2002 21:33:00 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15638.30407.605257.563235@wombat.chubb.wattle.id.au>
Date: Mon, 24 Jun 2002 11:32:55 +1000
To: Jeff Meininger <jeffm@boxybutgood.com>
Cc: linux-kernel@vger.kernel.org
Subject: loopback block device 'offset' - 2GB limit?
In-Reply-To: <708520218@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> "Jeff" == Jeff Meininger <jeffm@boxybutgood.com> writes:

Jeff> struct loop_info has a 32-bit 'int' offset (for x86 anyway), so
Jeff> it might require something tricky.  

The Large Block Device patch enables this.  There'll be a patch
against 2.5.24 coming soon.


PeterC
