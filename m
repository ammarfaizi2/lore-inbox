Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUF3Rdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUF3Rdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266764AbUF3Rdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:33:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:13736 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266487AbUF3Rdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:33:39 -0400
Date: Wed, 30 Jun 2004 10:32:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Provide console_suspend() and console_resume()
Message-Id: <20040630103239.1209d1c6.akpm@osdl.org>
In-Reply-To: <20040630123727.GA16409@elf.ucw.cz>
References: <20040614151217.H14403@flint.arm.linux.org.uk>
	<20040614151307.I14403@flint.arm.linux.org.uk>
	<20040630123727.GA16409@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > Add console_suspend() and console_resume() methods so the serial drivers
> > can disable console output before suspending a port, and re-enable output
> > afterwards.
> 
> Could it be called console_stop()/console_start()? suspend/resume
> sounds like power managment, and it is unrelated....

That's exactly what we ended up doing.
