Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVBIWJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVBIWJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 17:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVBIWJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 17:09:34 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:17130 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261947AbVBIWJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 17:09:31 -0500
Subject: tg3 broken in bk current?
From: john stultz <johnstul@us.ibm.com>
To: davem@davemloft.net
Cc: mchan@brooadcom.com, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 09 Feb 2005 14:09:27 -0800
Message-Id: <1107986967.11683.99.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, 
	I'm having problems w/ the tg3 driver on IBM x440 and x445 systems. It
seems the link doesn't hold and constantly flickers on and off.

Reverting this patch appears to have fixed the issue.
http://linus.bkbits.net:8080/linux-2.5/cset%4042016512Q5lCWar_OBNu5GAr_sjOvA?nav=index.html|ChangeSet@-7d

Let me know if I can help test any alternative solutions.

thanks
-john


