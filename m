Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279667AbRJ0BmU>; Fri, 26 Oct 2001 21:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279669AbRJ0BmK>; Fri, 26 Oct 2001 21:42:10 -0400
Received: from firebird.planetinternet.be ([195.95.34.5]:58128 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S279667AbRJ0Blz>; Fri, 26 Oct 2001 21:41:55 -0400
Date: Sat, 27 Oct 2001 03:42:21 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: Deathlock with 2.4.13
Message-ID: <20011027034221.A165@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just had a freeze with 2.4.13 + ext3-0.9.13.  I was unable to
switch vc, but they keyboard still responded.

I pressed alt-scroll lock a few times, and the only 4 address I
got where:
c0133aa68
c0133aa6f
c0133aae8
c0133aaef

This is inside d_lookup.  ksymoops translates the first too
d_lookup+5c/f4.

Can I do anything else to help debug this?


Kurt

