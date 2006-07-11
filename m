Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWGKHNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWGKHNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWGKHNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:13:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5353 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965099AbWGKHNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:13:13 -0400
Subject: Re: [PATCH] irqtrace-option-off-compile-fix
From: Arjan van de Ven <arjan@infradead.org>
To: tim.c.chen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
In-Reply-To: <1152577120.7654.9.camel@localhost.localdomain>
References: <1152577120.7654.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 09:13:09 +0200
Message-Id: <1152601989.3128.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 17:18 -0700, Tim Chen wrote:
> When CONFIG_TRACE_IRQFLAGS_SUPPORT is turned off, the latest kernel has
> compile errors.  The patch below fix the problems.


Hi,

which architecture did you see this on? (asking because IA64 and PPC
compile just fine without this, and for x86 and x86-64 this is not an
option you can turn off as user, it's not a user selectable config
option but it's a "I have this feature in arch" option)

Greetings,
   Arjan van de Ven

