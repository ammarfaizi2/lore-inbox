Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUKTFE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUKTFE5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUKTFCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 00:02:22 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:22166 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263099AbUKTEzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 23:55:43 -0500
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Torben Hohn <torbenh@informatik.uni-bremen.de>,
       Jody McIntyre <scjody@modernduck.com>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <87y8ha1wcb.fsf@sulphur.joq.us>
References: <87y8ha1wcb.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Fri, 19 Nov 2004 21:44:21 -0500
Message-Id: <1100918661.26068.16.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 16:39 -0600, Jack O'Quin wrote:
> The realtime-lsm Linux Security Module, written by Torben Hohn and
> Jack O'Quin with significant help from Chris Wright and Jody McIntyre,
> selectively grants realtime capabilities to specific user groups or
> applications.

Hmm, are all these includes necessary for this small patch?

+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+#include <linux/smp_lock.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/ptrace.h>
+#include <linux/sysctl.h>
+#include <linux/moduleparam.h>

Lee

