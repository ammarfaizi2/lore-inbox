Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbTLVHh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 02:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTLVHh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 02:37:58 -0500
Received: from imr1.ericy.com ([198.24.6.9]:9949 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id S264333AbTLVHh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 02:37:57 -0500
From: Frederic Rossi <frederic.rossi@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16358.40543.878289.421591@localhost.localdomain>
Date: Mon, 22 Dec 2003 02:33:51 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Frederic Rossi <frederic.rossi@ericsson.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] AEM v0.5.3 on kernel 2.6.0
In-Reply-To: <3FE2203A.7090608@pobox.com>
References: <16354.4831.508501.934390@localhost.localdomain>
	<3FE2203A.7090608@pobox.com>
X-Mailer: VM 7.07 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik wrote:
> Frederic Rossi wrote:
> > 
> > AEM (Asynchronous Event Mechanism) is an extension providing a native 
> > support for asynchronous events in the Linux kernel. 
> 
> 
> The kernel already supports this, 

this? you mean crossing the kernel to user space right?

> via netlink.
> 

I can imagine many ways to solve "this", netlink, write data
to the file system, /proc or whatever system calls (read ()?)

For this specific part AEM is using a memory based scheme.
Unless you have something very specific in mind, I don't see
how netlink could be of any help to solve the problem efficiently.

> 	Jeff

Frederic
