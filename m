Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTECRqs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 13:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTECRqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 13:46:48 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:60812 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263183AbTECRqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 13:46:47 -0400
Date: Sat, 3 May 2003 10:59:13 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: DECNET in latest BK
Message-ID: <20030503175913.GA13595@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't build, I didn't config it out by mistake.  Dunno if anyone uses
decnet.

net/decnet/dn_route.c: In function `dn_route_output_slow':
net/decnet/dn_route.c:1058: `flp' undeclared (first use in this function)
net/decnet/dn_route.c:1058: (Each undeclared identifier is reported only once
net/decnet/dn_route.c:1058: for each function it appears in.)
net/decnet/dn_route.c: In function `dn_route_input_slow':
net/decnet/dn_route.c:1183: structure has no member named `fwmark'
make[2]: *** [net/decnet/dn_route.o] Error 1
make[1]: *** [net/decnet] Error 2
make: *** [net] Error 2

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
