Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUJGTMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUJGTMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUJGTLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:11:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:51690 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267903AbUJGTE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:04:59 -0400
Subject: Re: Probable module bug in linux-2.6.5-1.358
From: Stephen Hemminger <shemminger@osdl.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
Content-Type: text/plain
Organization: Open Source Development Lab
Date: Thu, 07 Oct 2004 12:05:03 -0700
Message-Id: <1097175903.29576.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since you want to play fast and loose with the GPL and modules
licensing, I see no reason to help you debug your problem.

If you can reproduce the same problem with some GPL version of
standalone (even dummy) code, then come back and see us sometime.

--------------
/*
 *   Since some in the Linux-kernel development group want to play
 *   lawyer, and require that a GPL License exist for every kernel
 *   module,  I provide the following:
 *
 *   Everything in this file (only) is released under the so-called
 *   GNU Public License, incorporated herein by reference.
 *
 *   Now, we just link this with any proprietary code and everybody
 *   but the lawyers are happy.
 */
#ifndef __KERNEL__
#define __KERNEL__
#endif
#ifndef MODULE
#define MODULE
#endif
#include <linux/module.h>
#if defined(MODULE_LICENSE)
MODULE_LICENSE("GPL");
#endif


