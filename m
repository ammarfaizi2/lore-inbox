Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWINNlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWINNlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 09:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWINNlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 09:41:11 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:51019 "EHLO csg-cluster.dwd.de")
	by vger.kernel.org with ESMTP id S1750727AbWINNlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 09:41:10 -0400
Date: Thu, 14 Sep 2006 13:41:09 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: LM85 problems with 2.6.16.x
Message-ID: <Pine.LNX.4.64.0609141334070.879@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am using a Tyan S4882 motherboard with 4 CPU's that has a LM85 sensor chip
which reports the following message during boot:


     .
     .
     ipmi device interface
     Enabling SMBus multiplexing for Tyan S4882
     lm85 0-002e: Client (0,0x2e) config is locked.
     lm85 0-002e: Client (0,0x2e) is not ready.
     lm85 0-002e: Client (0,0x2e) VxI mode is set. Please report this to the lm85 maintainer.

Looking at /var/log/messages I also can see multiple entries of:

     i2c_adapter i2c-0: SMBus collision!

Any idea what is causing this and what I can do to remove the problem?

Who is the lm85 maintainer? In MAINTANERS I only found LM80 and LM83. In
lm85.c there is Justin Thiessen <jthiessen@penguincomputing.com> in the
Copyright, but failed to contact him.

Thanks,
Holger
-- 

