Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTIQSyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 14:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbTIQSyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 14:54:19 -0400
Received: from smtp1.libero.it ([193.70.192.51]:63662 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S262629AbTIQSyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 14:54:18 -0400
From: Eduard Roccatello <liste@roccatello.it>
Organization: Pcimprover.it
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5-mm2 ipv6 and irda warnings
Date: Wed, 17 Sep 2003 09:56:21 +0200
User-Agent: KMail/1.5.2
X-IRC: #hardware@azzurra.org #rolug@freenode
X-Jabber: eduardroccatello@jabber.linux.it
X-GPG-Keyserver: keyserver.linux.it
X-GPG-FingerPrint: F7B3 3844 038C D582 2C04 4488 8D46 368B 474D 6DB0
X-GPG-KeyID: 474D6DB0
X-Website: http://www.pcimprover.it
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309170956.21850.liste@roccatello.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test5-mm2 gives me these warnings:

net/ipv6/ipcomp6.c: In function `ipcomp6_input`:
net/ipv6/ipcomp6.c:61: warning: `skb_linearize` is deprecated (declared at 
include/linux/skbuff.h:1131)

net/ipv6/ipcomp6.c: In function `ipcomp6_output`:
net/ipv6/ipcomp6.c:174: warning: `skb_linearize` is deprecated (declared at 
include/linux/skbuff.h:1131)

net/irda/irlap_frame.c: In function `irlap_driver_rcv`:
net/irda/irlap_frame.c:1306: warning: `skb_linearize` is deprecated 
(declared at include/linux/skbuff.h:1131)

gcc is 3.2.3
-- 
Eduard <Master^Shadow> Roccatello

Pcimprover.it Admin - http://www.pcimprover.it
S.P.I.N.E. Group - http://www.spine-group.org

