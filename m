Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUEMUGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUEMUGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUEMTxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:53:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:1485 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264591AbUEMTik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:38:40 -0400
Date: Thu, 13 May 2004 12:38:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.6.6-mm2
Message-Id: <20040513123809.01398f93.akpm@osdl.org>
In-Reply-To: <20040513121850.B22989@build.pdx.osdl.net>
References: <20040513032736.40651f8e.akpm@osdl.org>
	<20040513114520.A8442@infradead.org>
	<20040513035134.2e9013ea.akpm@osdl.org>
	<20040513121850.B22989@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> 
>  +static int capability_mask;
>  +module_param_named(mask, capability_mask, int, 0);
>  +MODULE_PARM_DESC(mask, "Mask of capability checks to ignore");

Is there a way to make this tunable at runtime, btw?
