Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263074AbVCXHDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbVCXHDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbVCXHBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:01:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59065 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263069AbVCXHAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:00:43 -0500
Date: Thu, 24 Mar 2005 08:00:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: sounak chakraborty <sounakrin@yahoo.co.in>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched.c  function
In-Reply-To: <20050324044331.10713.qmail@web53305.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503240759060.6309@yvahk01.tjqt.qr>
References: <20050324044331.10713.qmail@web53305.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Dear sir,
>
> I am new to kernel. I want to know which function in
>the file sched.c or procedure is called to bring a
>process for processing in the CPU after context
>switching. 

In schedule(), context_switch() is called -- there is not any processing 
needed, the task state is just copied from memory back into CPU
and.. +finished.
There's a finish_task_switch(), though.


Jan Engelhardt
-- 
