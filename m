Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVDRMqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVDRMqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVDRMqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:46:10 -0400
Received: from smtp06.web.de ([217.72.192.224]:34788 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S262060AbVDRMqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:46:08 -0400
Subject: need help: scheduling
From: Gunter <mlkhma@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 18 Apr 2005 15:00:11 +0200
Message-Id: <1113829211.6730.8.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I need help about scheduling. I hope i understand the basics for my
question: An active prozess counts the remaining cpu time in jifies. By
every timer interrupt the scheduler decrements the variable time_slice.

Where is the scheduler initializing the interrupt timer (init_timer).
And where gets the struct timer_list the next interrupt (expires). At
last i want know where the scheduler calls add_timer. Or is there an
other way?

Thank You
Gunter

