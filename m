Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUCXUc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUCXUc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:32:58 -0500
Received: from linux-bt.org ([217.160.111.169]:14759 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261603AbUCXUc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:32:56 -0500
Subject: Re: Compile problem on sparc64
From: Marcel Holtmann <marcel@holtmann.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SPARC Linux Mailing List <sparclinux@vger.kernel.org>
In-Reply-To: <20040324121914.00fb9bf9.davem@redhat.com>
References: <1080130448.2515.108.camel@pegasus>
	 <20040324121914.00fb9bf9.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1080160367.2309.71.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 21:32:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> [ Please us sparclinux@vger.kernel.org in the future, thanks... ]

I will do.

> > I am using Debian Sid with GCC 3.3.3 (Debian 20040320) and I got the
> > following error on my sparc64 platform while compiling the latest
> > Bitkeeper sources from 2.6:
> 
> This should cure it, let me know if it doesn't.

Seems that this is not enough. Now I get this one:

  CC      arch/sparc64/kernel/process.o
arch/sparc64/kernel/process.c: In function `flush_thread':
arch/sparc64/kernel/process.c:435: warning: use of cast expressions as lvalues is deprecated

Regards

Marcel


