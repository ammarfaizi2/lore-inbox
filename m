Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264924AbSJVSph>; Tue, 22 Oct 2002 14:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSJVSpC>; Tue, 22 Oct 2002 14:45:02 -0400
Received: from 166.Red-80-36-134.pooles.rima-tde.net ([80.36.134.166]:16768
	"EHLO apocalipsis") by vger.kernel.org with ESMTP
	id <S264920AbSJVSoT>; Tue, 22 Oct 2002 14:44:19 -0400
Date: Tue, 22 Oct 2002 20:49:20 +0200
From: "Juan M. de la Torre" <jmtorre@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Problem compiling 2.5.44 (net/ipv4/raw.c)
Message-ID: <20021022184920.GA8742@apocalipsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  net/ipv4/raw.c: In function `raw_send_hdrinc':
  net/ipv4/raw.c:297: `NF_IP_LOCAL_OUT' undeclared (first use in this
  function)
  net/ipv4/raw.c:297: (Each undeclared identifier is reported only once
  net/ipv4/raw.c:297: for each function it appears in.)
  make[2]: *** [net/ipv4/raw.o] Error 1
  make[1]: *** [net/ipv4] Error 2
  make: *** [net] Error 2

 net/ipv4/raw.c includes linux/netfilter.h, but not linux/netfilter_ipv4.h
 (NF_IP_LOCAL_OUT is defined in netfilter_ipv4.h).

Regards,
 Juanma

-- 
/jm

