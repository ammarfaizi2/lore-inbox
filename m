Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUIGUCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUIGUCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUIGUBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:01:51 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:14319 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268532AbUIGTw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:52:59 -0400
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Michael.Waychison@Sun.COM,
       plars@linuxtestproject.org, Brian.Somers@Sun.COM,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
X-Message-Flag: Warning: May contain useful information
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com>
	<20040830161126.585a6b62.davem@davemloft.net>
	<1094238777.9913.278.camel@plars.austin.ibm.com>
	<4138C3DD.1060005@sun.com> <52acw7rtrw.fsf@topspin.com>
	<20040903133059.483e98a0.davem@davemloft.net>
	<52ekljq6l2.fsf@topspin.com> <20040907133332.4ceb3b5a@localhost>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 07 Sep 2004 12:52:56 -0700
In-Reply-To: <20040907133332.4ceb3b5a@localhost> (Jake Moilanen's message of
 "Tue, 7 Sep 2004 13:33:32 -0500")
Message-ID: <52isapkg9z.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Sep 2004 19:52:56.0479 (UTC) FILETIME=[451F72F0:01C49514]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jake> Whenever an adapter reset is done (eg ifconfig up) on the
    Jake> same adapter that SoL is using, you'll lose SoL.  SoL
    Jake> usually comes back, although I've not had much luck ever
    Jake> since the Sun auto negotiation patch went in.  One
    Jake> fix/workaround to not losing your SoL connection is having
    Jake> the network go only over eth1 (assuming you have two switch
    Jake> modules).

Thanks -- unfortunately I only have one switch module :(

With the 3.9 tg3 driver, neither SoL nor the real network seems to
ever come back.  As far as I can tell, the network is dead (and
without SoL there's no way for me to see what happens to the kernel).

Have you had success with the latest tg3 on JS20?

 - R.
