Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbVIBARK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbVIBARK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 20:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbVIBARJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 20:17:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030589AbVIBARG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 20:17:06 -0400
Date: Thu, 1 Sep 2005 17:16:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 0/10] m68k/thread_info merge
Message-Id: <20050901171621.33d41b3c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0509012211010.8099@scrub.home>
References: <Pine.LNX.4.61.0509012211010.8099@scrub.home>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> This patch series brings the m68k closer to a working state. It consists 
> of two basic parts, the first five patches do the minimal changes to get 
> m68k compiling in mainline, the last five patches do a cleanup of the 
> kernel API.

Can I assume that the five m68k patches can be split apart from the five
patches which dink with task_struct?  ie: if the task_struct patches go in
later, does anything bad happen?
