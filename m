Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTDMVne (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 17:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTDMVne (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 17:43:34 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39690
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261899AbTDMVnd 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 17:43:33 -0400
Subject: Re: Preempt on PowerPC/SMP appears to leak memory
From: Robert Love <rml@tech9.net>
To: David Brown <dave@codewhore.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030412152951.GA10367@codewhore.org>
References: <20030412152951.GA10367@codewhore.org>
Content-Type: text/plain
Organization: 
Message-Id: <1050270927.767.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 13 Apr 2003 17:55:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 11:29, David Brown wrote:

> Before I debug/trace any further, I'm curious as to whether or not
> preempt is known to work on PowerPC in SMP mode. If it's supposed to,
> I'd be happy to capture any data that may help.

It should work OK.  The memory leak is certainly unexpected.

Someone else has reported a similar leak on x86... so you are not
alone.  It might be a bug in the 2.4.20 kernel itself.  Think you can
track down what is leaking?

	Robert Love

