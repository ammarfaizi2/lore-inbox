Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269453AbUI3Tjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269453AbUI3Tjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269458AbUI3Tjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:39:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:50361 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269453AbUI3Tjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:39:53 -0400
Date: Thu, 30 Sep 2004 12:36:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
Cc: john.ronciak@intel.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, jeremy@goop.org
Subject: Re: [PATCH] Fix for spurious interrupts on e100 resume
Message-Id: <20040930123632.61d2188a.akpm@osdl.org>
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E02B55EF6@orsmsx408>
References: <468F3FDA28AA87429AD807992E22D07E02B55EF6@orsmsx408>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Venkatesan, Ganesh" <ganesh.venkatesan@intel.com> wrote:
>
> I propose that we remove this patch from the -mm tree. We will work on a
>  clean solution and send a patch soon. Please see further discussion on
>  this under the subject "2.6.9-rc2-mm4 e100 enable_irq unbalanced from"

OK, thanks.  I'll retain the current patch in -mm until the problem is
fixed for real.  We wouldn't want to be forgetting about it ;)
