Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbTJYU5H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbTJYU5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:57:07 -0400
Received: from pop.gmx.net ([213.165.64.20]:37253 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262835AbTJYU5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:57:04 -0400
X-Authenticated: #2034091
Message-ID: <2523214.1067115416222.JavaMail.jpl@remotejava>
Date: Sat, 25 Oct 2003 22:56:56 +0200 (CEST)
From: Jan Ploski <jpljpl@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-testX and pppd/pppoe stuck after connecting
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ever since I upgraded from 2.4.18 to 2.6.0-test? (now -test8),
I have been encountering problems with my pppd/pppoe setup.
Specifically, right after the ppp0 interface is brought up, and several
packets go through that interface (4-5 packets RX/TX), no more packets
are transmitted until I restart pppd and reconnect to my ISP.
ping www.google.com will report 100% packet loss, and I cannot see the
TX packet count on ppp0 increasing. Nothing suspicious appears in ppp.log.
More often than not, I have to reconnect multiple times until at last
a working connection is established.

I may have not included all required information, but I don't know what
might be useful in diagnosing this problem (this knowledge would possibly
let me correct it without posting). I believe it is kernel-related because
with 2.4.x everything works fine in the same circumstances. The software
versions are: pppd version 2.4.1, pppoe version 3.3 (from roaringpenguin.com)

I would be grateful if you CC'ed me in replies.

Best regards -
Jan Ploski

