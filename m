Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130044AbRB1Cf0>; Tue, 27 Feb 2001 21:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130048AbRB1CfQ>; Tue, 27 Feb 2001 21:35:16 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:15099 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S130044AbRB1CfB>; Tue, 27 Feb 2001 21:35:01 -0500
Message-ID: <3A9C6336.D2E086A6@mvista.com>
Date: Tue, 27 Feb 2001 18:32:22 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rx_copybreak value for non-i386 architectures
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I notice that many net drivers set rx_copybreak to 1518 (the max packet size)
for non-i386 architectures.  Once I thought I understood it and it seems
related to cache line alignment.  However, I am not sure exactly about the
reason now.  Can someone enlighten me a little bit?

Basically I try to understand whether for MIPS architectures we need to set
this value as well.

Please CC your reply to my email address.

TIA.

Jun
