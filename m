Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269361AbUJRDdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269361AbUJRDdS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 23:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269364AbUJRDdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 23:33:18 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:43930 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S269361AbUJRDdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 23:33:16 -0400
Date: Mon, 18 Oct 2004 12:33:19 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: Robin Holt <holt@sgi.com>
Subject: Re: Yet another crash dump tool
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, oda@valinux.co.jp
In-Reply-To: <20041015130602.GA32020@lnx-holt.americas.sgi.com>
References: <20041015081246.26EB.ODA@valinux.co.jp> <20041015130602.GA32020@lnx-holt.americas.sgi.com>
Message-Id: <20041018112919.26F7.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Can
> you add a feature to only dump kernel pages, kernel pages +
> page/buffer cache, or all of memory?  If not, this is a step

yes. actually the mini kernel dump has an interface from the
operational kernel to the mini kernel that contains "what pfn
should be dumped". 

It takes 2-3 minutes to dump 8GB memory (our typical customer).
So it is relative low priority to support selecting dump pages,
but I remind it.

> backwards in dumping.  We have seen RFPs from some potential
> customers for as much as 16PB of memory.  I am not sure that
> anybody builds hardware that scales to that level, but it
> certainly shows you a problem.

Maybe we should develop another fault isolation method on such
system.

> classified data.  They require assurances that the minimal amount
> of their unclassified data is being sent outside their control to
> reduce the chance that someone can infer their methods.

It is an important point to provide the fault analysis service.
We are considering that point. It is rather an operational problem 
than technical problem. We are planning some cryptographic mechanism.

Thank you.
-- 
Itsuro ODA <oda@valinux.co.jp>

