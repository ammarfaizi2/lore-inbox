Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262366AbSKTTLL>; Wed, 20 Nov 2002 14:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSKTTJp>; Wed, 20 Nov 2002 14:09:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262464AbSKTTJc>;
	Wed, 20 Nov 2002 14:09:32 -0500
Subject: root=LABEL=/ broken in 2.5.47
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 11:16:36 -0800
Message-Id: <1037819796.1413.31.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that sometime in the recent 2.5 progress (probably when initrd
changes went in), the root device naming changed.
Specifying "root=LABEL=/" used to work, now the only valid parameter
seems to be a actual device (as in "root=/dev/hda2" ).

Is this an intentional change? or a bug introduced?

Is there an existing patch to fix it?





