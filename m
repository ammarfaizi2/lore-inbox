Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbTIJWoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbTIJWnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:43:17 -0400
Received: from postino3.prima.com.ar ([200.42.0.148]:45583 "HELO
	postino3.prima.com.ar") by vger.kernel.org with SMTP
	id S265914AbTIJWml convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:42:41 -0400
Subject: test5-bk1: Compilation Error in net/atm/br2684.c
From: Matias Alejo Garcia <kernel@matiu.com.ar>
To: Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Message-Id: <1063236505.4636.2.camel@runner>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 10 Sep 2003 19:28:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiling 2.6.0test5-bk1, I got the following:

-------------
net/atm/br2684.c: In function `br2684_seq_show':
net/atm/br2684.c:735: `pos' undeclared (first use in this function)
net/atm/br2684.c:735: (Each undeclared identifier is reported only once
net/atm/br2684.c:735: for each function it appears in.)
net/atm/br2684.c:736: `buf' undeclared (first use in this function)
make[2]: *** [net/atm/br2684.o] Error 1
make[1]: *** [net/atm] Error 2


Related configuration:
-------------
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
CONFIG_ATM_BR2684_IPFILTER=y
CONFIG_VLAN_8021Q=m


matías

-- 
matías <-> http://matiu.com.ar
