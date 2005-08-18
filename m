Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVHRO7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVHRO7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 10:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVHRO7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 10:59:07 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:11677 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750823AbVHRO7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 10:59:06 -0400
Subject: [QUESTION] Why isn't there a unregister_die_notifier?
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 18 Aug 2005 10:59:02 -0400
Message-Id: <1124377142.5186.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a debugging module that I want to register a die notifier.
But I just noticed that I can't unregister it.  So for now I either just
keep the module loaded and never unloaded it, compile it into the
kernel, or ifdef out the register_die_notifier when loaded as a module.

Is there some reason that there isn't such a call, or maybe there is,
and I don't see it (called something else). Or is this something that
should be added?

Thanks,

-- Steve


