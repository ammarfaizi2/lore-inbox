Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbUKKMVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbUKKMVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 07:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUKKMVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 07:21:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:55495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262227AbUKKMVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 07:21:42 -0500
Date: Thu, 11 Nov 2004 04:21:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.10-rc1-mm5: yenta_socket issue
Message-Id: <20041111042130.161d2c28.akpm@osdl.org>
In-Reply-To: <200411111311.44664.rjw@sisk.pl>
References: <20041111012333.1b529478.akpm@osdl.org>
	<200411111311.44664.rjw@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Thursday 11 of November 2004 10:23, Andrew Morton wrote:
> > 
> > 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/
> 
> On an AMD64 box (Athlon 64 + NForce3) I get these messages from yenta_socket:
> 
> yenta_socket: Unknown symbol dead_socket
> yenta_socket: Unknown symbol pcmcia_register_socket
> yenta_socket: Unknown symbol pcmcia_socket_dev_resume
> yenta_socket: Unknown symbol pcmcia_parse_events
> yenta_socket: Unknown symbol pcmcia_socket_dev_suspend
> yenta_socket: Unknown symbol pcmcia_unregister_socket
> 

hm, I haven't seen that before.  Rusty, any ideas what we might have done
to provoke this?

