Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUFVPH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUFVPH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUFVPEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:04:08 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:53359 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264571AbUFVPCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:02:09 -0400
Subject: Re: 2.6.7-bk5 scheduling while atomic
From: Paul Fulghum <paulkf@microgate.com>
To: Klaus Dittrich <kladit@t-online.de>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040622135529.GA838@xeon2.local.here>
References: <20040622135529.GA838@xeon2.local.here>
Content-Type: text/plain
Organization: 
Message-Id: <1087916526.2004.3.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jun 2004 10:02:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 08:55, Klaus Dittrich wrote:
> System smp (2 x XEON, I7505) preemptive 
> 
> With kernel-2.6.7-bk5 I get a lot of 
> "kernel: bad: scheduling while atomic!" messages 
> during startup.
> 
> 2.6.7 runs fine using the basically the same configuration.
> 
> Did anybody else see this ? 

Yes, same here.
kernel-2.6.7-bk5
SMP (2 x Pentium II)

2.6.7 runs fine.

> Here is an excerpt of /var/log/messages  ..

The specific messages are different in my log
but the structure is the same: floods of
scheduling while atomic messages.

--
Paul Fulghum
paulkf@microgate.com


