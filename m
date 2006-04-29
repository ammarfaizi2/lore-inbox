Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWD2Gqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWD2Gqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 02:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWD2Gqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 02:46:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751487AbWD2Gqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 02:46:37 -0400
Date: Fri, 28 Apr 2006 23:44:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: schwidefsky@de.ibm.com, penberg@cs.helsinki.fi, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-Id: <20060428234441.1407c82f.akpm@osdl.org>
In-Reply-To: <20060428112225.418cadd9.holzheu@de.ibm.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Holzheu <holzheu@de.ibm.com> wrote:
>
>  As mount point for the filesystem /sys/hypervisor is created.

What does this mean, btw?  I don't see code there creating a new sysfs
directory, and userspace cannot do this.

Confused.

Also, "/sys/hypervisor" is probably insufficiently specific.  In a few
years time people will be asking "Which hypervisor?  We have eighteen of them!".

