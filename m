Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270256AbTG1Qk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 12:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270271AbTG1Qk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 12:40:28 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:2322 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270256AbTG1Qk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 12:40:27 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6: irtty vs. irtty-sir
Date: Mon, 28 Jul 2003 20:31:09 +0400
User-Agent: KMail/1.5
Cc: irda-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307282031.09714.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irtty is dabbed as broken in Makefile.

Question - is it fundamentally broken, sometimes broken or under special 
conditions broken? :)

I need to decide if I replace default ldisc-11 by irtty-sir in 2.6 (risking 
that some dongles stop working for some people) or leave it as irtty and tell 
guys who build kernel to use CONFIG_IRTTY_OLD

TIA

-andrey
