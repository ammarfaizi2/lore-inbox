Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbULBWrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbULBWrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbULBWrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:47:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:54938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261790AbULBWrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:47:20 -0500
Date: Thu, 2 Dec 2004 14:51:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: joe.korty@ccur.com
Cc: roland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix uninitialized variable in waitid(2)
Message-Id: <20041202145125.301bb295.akpm@osdl.org>
In-Reply-To: <20041202223951.GA22488@tsunami.ccur.com>
References: <20041201232204.GA29829@tsunami.ccur.com>
	<200412012358.iB1Nwk3C002166@magilla.sf.frob.com>
	<20041202175418.GA9716@tsunami.ccur.com>
	<20041202223951.GA22488@tsunami.ccur.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
> Specify an initial value signal_struct's field stop_state
> whenever a signal_struct variable is created.

whew.  Thanks.
