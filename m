Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTLXVOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 16:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTLXVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 16:14:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:21174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263850AbTLXVOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 16:14:45 -0500
Date: Wed, 24 Dec 2003 13:15:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric <eric@cisu.net>
Cc: linux-kernel@vger.kernel.org, lnz@dandelion.com
Subject: Re: 2.6.0 and VMWare Buslogic Error?
Message-Id: <20031224131509.4460fade.akpm@osdl.org>
In-Reply-To: <200312241500.27156.eric@cisu.net>
References: <200312241500.27156.eric@cisu.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric <eric@cisu.net> wrote:
>
> ERROR: SCSI host `BusLogic' has no error handling
> ERROR: This is not a safe way to run your SCSI host
> ERROR: The error handling must be added to this driver

Please test with

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm1/broken-out/buslogic-update.patch

applied.
