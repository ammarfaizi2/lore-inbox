Return-Path: <linux-kernel-owner+w=401wt.eu-S1751192AbWLLGT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWLLGT1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWLLGT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:19:27 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:55543 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbWLLGT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:19:26 -0500
Message-ID: <457E498C.1050806@bx.jp.nec.com>
Date: Tue, 12 Dec 2006 15:17:48 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
Reply-To: k-keiichi@bx.jp.nec.com
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.6.19 0/6] proposal for dynamic configurable netconsole
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









