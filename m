Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUI0Pvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUI0Pvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUI0Pvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:51:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266511AbUI0PvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:51:24 -0400
Date: Mon, 27 Sep 2004 11:51:12 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: "akpm@osdl.org" <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SELinux performance improvement with RCU
In-Reply-To: <200409271057.i8RAvcA1007873@mailsv.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0409271146550.21876-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004, Kaigai Kohei wrote:

> Because this patch depends on two external function: atomic_inc_return()
> and list_replace_rcu(), I was waiting for those functions to be merged
> into 2.6.9-rc2-mm2 tree.
> Please apply this.

Kaigai, 

Have you addressed the lockups which Stephen Smalley reported to you when 
testing this code?

You also have not addressed issues raised regarding low end performance.

Also, the patch has not been fully vetted by the maintainers (Stephen and
myself).



- James
-- 
James Morris
<jmorris@redhat.com>



