Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbUJXMny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUJXMny (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 08:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUJXMny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 08:43:54 -0400
Received: from mail.linicks.net ([217.204.244.146]:18180 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261460AbUJXMnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 08:43:52 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE warning: "Wait for ready failed before probe!"
Date: Sun, 24 Oct 2004 13:43:50 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410241343.50664.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 1. Are these warnings usual for a nonexistant IDE drive?
>> 2. Could they be toned down?

> Disable CONFIG_IDE_GENERIC
> - or -
> Use the ideX=noprobe boot parm, replacing X with the interface number
> not to probe.

> Kurt

I started to get these messages in logs since building 2.6.9, and a google 
reveals this from Alan Cox:

http://www.redhat.com/archives/fedora-test-list/2004-September/msg00300.html

So, will these be turned off, or do we have to follow above instructions?

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
