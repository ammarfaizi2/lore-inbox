Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWIISUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWIISUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 14:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWIISUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 14:20:34 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:18190 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1751355AbWIISUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 14:20:32 -0400
Subject: Re: Re: [patch 6/6] process filtering for fault-injection
	capabilities
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060908070011.GA8889@miraclelinux.com>
References: <1157696997.9460.99.camel@localhost.localdomain>
	 <20060908070011.GA8889@miraclelinux.com>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 11:14:58 -0700
Message-Id: <1157825698.9460.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 15:00 +0800, Akinobu Mita wrote:
> Now I'm writing the filter which allow failing only for a specific
> module by using unwinding kernel stacks API.

Are you planning to use STACK_UNWIND?  I see that only i386
supports STACK_UNWIND.

Perhaps the much simpler STACKTRACE would suffice -- supported
by i386, x86_64, and s390?

