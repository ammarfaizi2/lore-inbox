Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbUJZUUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUJZUUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbUJZUSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:18:24 -0400
Received: from mail.linicks.net ([217.204.244.146]:64004 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261415AbUJZUSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:18:08 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: IDE warning: "Wait for ready failed before probe!"
Date: Tue, 26 Oct 2004 21:17:58 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410262117.58610.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strangely, or even twilight zone stuff, I am building right now and will boot 
new kernel with the CONFIG_IDE_GENERIC = n - this fixes it reportedly.  Only 
warnings anyway, but I think we all like *clean* boots.

A couple of mails with Bartlomiej assured me that it isn't required on 
modern(ish) machines that have PCI (in theory), so do not need that option.

That will stop the probe, and the post from Alan re the Redhat thread suggests 
it is a debug warning anyway that maybe was never removed.

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
