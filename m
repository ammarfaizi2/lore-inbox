Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbTBGWKj>; Fri, 7 Feb 2003 17:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTBGWKj>; Fri, 7 Feb 2003 17:10:39 -0500
Received: from fmr01.intel.com ([192.55.52.18]:48891 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266733AbTBGWKi>;
	Fri, 7 Feb 2003 17:10:38 -0500
Subject: Plans for non-iocl watchdog API?
From: Rusty Lynch <rusty@linux.co.intel.com>
To: wingel@nano-system.com, mochel@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Feb 2003 14:16:06 -0800
Message-Id: <1044656167.1134.10.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting ready to write a new watchdog timer for a couple of
different cpci single board computers, and was wondering if there are
plans to move to a sysfs based api.  The current model (as documented in
Documentation/watchdog-api.txt) is based on the old way of doing things,
with ioctls for configuring and reading/writing to a char device for
refreshing the watchdog.

    --rustyl



