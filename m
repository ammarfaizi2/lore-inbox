Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVBNLeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVBNLeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 06:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVBNLeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 06:34:24 -0500
Received: from mail.linicks.net ([217.204.244.146]:37773 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261374AbVBNLeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 06:34:21 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: make menuconfig
Date: Mon, 14 Feb 2005 11:34:19 +0000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502141134.19094.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I only just noticed this, but been building kernel source for a long time.  On 
my 233 over ssh, it is a bit slow, and I just noticed this output when doing 
a 'make menuconfig':

make[1]: `scripts/fixdep' is up to date.
scripts/kconfig/mconf arch/i386/Kconfig
optimize  &&  ?
optimize  &&  ?
optimize  &&  ?
optimize  &&  ?

Are the  optimize  &&  ? lines normal?  I investigated, but can't work it out.  
This is from a current tree that has an uptime of > 50 days - I just needed 
to change one option in the build, so the existing .config is good.

Thanks,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
