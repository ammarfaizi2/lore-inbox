Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbUKOS6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUKOS6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 13:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUKOS6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 13:58:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:29627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261247AbUKOS6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 13:58:03 -0500
Date: Mon, 15 Nov 2004 10:58:01 -0800
From: Chris Wright <chrisw@osdl.org>
To: Dean Nelson <dcn@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041115105801.T14339@build.pdx.osdl.net>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com>; from dcn@sgi.com on Mon, Nov 15, 2004 at 12:35:57PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dean Nelson (dcn@sgi.com) wrote:
> +int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)

this should be static.

thanks,
-chris
