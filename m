Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVFKDSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVFKDSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 23:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVFKDSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 23:18:20 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:22937 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261558AbVFKDSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 23:18:16 -0400
Date: Fri, 10 Jun 2005 20:18:12 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: li nux <lnxluv@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: problem with module tainting the kernel
Message-Id: <20050610201812.037b6a01.rdunlap@xenotime.net>
In-Reply-To: <20050610152450.82261.qmail@web33315.mail.mud.yahoo.com>
References: <20050610152450.82261.qmail@web33315.mail.mud.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2005 08:24:50 -0700 (PDT) li nux wrote:

| In 2.6 kernels how to assure that on inserting our own
| module, it doesn't throw the warning:
| 
| "unsupported module, tainting kernel"

That string is not in the kernel source code that I can see.
Be more precise, please.


| what tainting depends on apart from the license string ?

load:

- CONFIG_MODVERSIONS is set but some symbol does not have
  version info

- a license that is not GPL-compatible

- no version magic info for the module

unload:

- forcefully unloading a module

---
~Randy
