Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUFIXvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUFIXvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUFIXuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:50:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:26243 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266234AbUFIXtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:49:52 -0400
Date: Wed, 9 Jun 2004 16:52:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-Id: <20040609165231.151e84e7.akpm@osdl.org>
In-Reply-To: <200406091944.15082.edt@aei.ca>
References: <1085689455.7831.8.camel@localhost>
	<200405271928.33451.edt@aei.ca>
	<200406032207.25602.edt@aei.ca>
	<200406091944.15082.edt@aei.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <edt@aei.ca> wrote:
>
> Hi,
> 
> I am still seeing these with 7-rc3-mm1...  No extra diag info either.   I would be
> really nice to see this one fixed.

So ide-print-failed-opcode.patch isn't working.  Presumably
HWGROUP(drive)->rq is null.

