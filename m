Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSKKFDD>; Mon, 11 Nov 2002 00:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSKKFDD>; Mon, 11 Nov 2002 00:03:03 -0500
Received: from pointblue.com.pl ([62.121.131.135]:53770 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S265523AbSKKFDC>;
	Mon, 11 Nov 2002 00:03:02 -0500
Subject: 2.5.47 ipv4 netfilter compile time error
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Nov 2002 04:56:07 +0000
Message-Id: <1036990568.24251.4.camel@flat41>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !


i've discovered this error during compilation:

net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

on demand i'll include .config

now i will switch off this one, and try to compile it without netfilter.
It is still impossilble to make saa7146 module too...

anyway, keep doing this good job folks.

--
Greg Iaskievitch




