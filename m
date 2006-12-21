Return-Path: <linux-kernel-owner+w=401wt.eu-S965190AbWLUJ6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWLUJ6Z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWLUJ6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:58:25 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:57842 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965187AbWLUJ6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:58:24 -0500
X-Greylist: delayed 87733 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 04:58:24 EST
Message-ID: <458A5AAE.30209@bx.jp.nec.com>
Date: Thu, 21 Dec 2006 18:58:06 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 2.6.19 take2 0/5] proposal for dynamic configurable netconsole
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keiichi KII <k-keiichi@bx.jp.nec.com>

The netconsole is a very useful module for collecting kernel message under
certain circumstances(e.g. disk logging fails, serial port is unavailable).

But current netconsole is not flexible. For example, if you want to change ip
address for logging agent, in the case of built-in netconsole, you can't change
config except for changing boot parameter and rebooting your system, or in the
case of module netconsole, you need to reload netconsole module.

So, I propose the following extended features for netconsole.

1) support for multiple logging agents.
2) add interface to access each parameter of netconsole
   using sysfs.

This patch is for linux-2.6.19 and is divided to each function.
Your comments are very welcome.

Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
---
-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com

