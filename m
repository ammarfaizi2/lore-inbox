Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTDMVpa (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 17:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTDMVpa (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 17:45:30 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:44554
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262001AbTDMVp3 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 17:45:29 -0400
Subject: Re: Preempt on PowerPC/SMP appears to leak memory
From: Robert Love <rml@tech9.net>
To: David Brown <dave@codewhore.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030412152951.GA10367@codewhore.org>
References: <20030412152951.GA10367@codewhore.org>
Content-Type: text/plain
Organization: 
Message-Id: <1050271044.767.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 13 Apr 2003 17:57:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 11:29, David Brown wrote:

> I recently applied the preempt-kernel-rml-2.4.21-pre1-1.patch from
> kernel.org to BenH's stable tree from rsync.penguinppc.org.

Oh, one other thing.  An updated patch for 2.4.20 is up:

http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.20-2.patch

It has a couple fixes for proper protection of per-CPU data, including
some PPC-specific ones.

	Robert Love

