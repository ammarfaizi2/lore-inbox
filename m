Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268954AbUJPWuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbUJPWuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 18:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUJPWuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 18:50:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:12750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268954AbUJPWuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 18:50:08 -0400
Date: Sat, 16 Oct 2004 15:48:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
Message-Id: <20041016154818.271a394b.akpm@osdl.org>
In-Reply-To: <417196AA.3090207@pobox.com>
References: <41719537.1080505@pobox.com>
	<417196AA.3090207@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> The only really notable changes in -bk3 -> -bk4 are the signal changes, 
> something in mm/vmscan.c.
> 

I'd be suspecting the vmscan.c change, but we allegedly fixed that later on.
Can you try reverting it?  (Can't reproduce the problem here)
