Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbWFTGmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWFTGmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWFTGmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:42:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40417 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965093AbWFTGmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:42:19 -0400
Date: Mon, 19 Jun 2006 23:42:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Add pacct_struct to fix some pacct bugs.
Message-Id: <20060619234212.b95e5734.akpm@osdl.org>
In-Reply-To: <449794BB.8010108@ak.jp.nec.com>
References: <449794BB.8010108@ak.jp.nec.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 15:24:59 +0900
KaiGai Kohei <kaigai@ak.jp.nec.com> wrote:

> Hi, I noticed three problems in pacct facility.
> 
> 1. Pacct facility has a possibility to write incorrect ac_flag
>    in multi-threading cases.
> 2. There is a possibility to be waken up OOM Killer from
>    pacct facility. It will cause system stall.
> 3. If several threads are killed at same time, There is
>    a possibility not to pick up a part of those accountings.
> 
> The attached patch will resolve those matters.
> Any comments please. Thanks,

Thanks, but you have three quite distinct bugs here, and three quite
distinct descriptions and, I think, three quite distinct fixes.

Would it be possible for you to prepare three patches?
