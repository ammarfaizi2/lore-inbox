Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUHRTJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUHRTJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 15:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUHRTJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 15:09:50 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:52629 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S267478AbUHRTJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 15:09:49 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.23 (Clear:RC:0(150.254.37.14):. Processed in 0.032089 secs)
Date: Wed, 18 Aug 2004 21:09:47 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.10.02) Personal
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1927711177.20040818210947@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: network regression using 2.6.8.x behind Cisco 1712
In-Reply-To: <1092849905.26056.17.camel@localhost.localdomain>
References: <1092817247.5178.6.camel@ondrej.sury.org>
 <1092849905.26056.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

echo "0" >>/proc/sys/net/ipv4/tcp_window_scaling see if that helps. If so
AC> then suspect somehting like the cisco or upstream router.
It propably is a tcp ws issue. I have the same thing.
Dave Miller & netdev friends will tell you to fix cisco.
Anyway, I belive I have isolated the changeset applied during the
developement of 2.6.8 that causes this. I might look for it (I do not
have it handy right now), so you might try to undo it before you
resolve your issue totally.
Anyway it is very cool that you say that it might be cisco. I
suspected my checkpoint fw-1 for the cause of it, but now I realize
it might be my cisco router! I will investigate that, thanks.

--
Regars,
Maciej


