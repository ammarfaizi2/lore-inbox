Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVAGHaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVAGHaQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVAGHaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:30:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:25027 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261298AbVAGHaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:30:13 -0500
Date: Thu, 6 Jan 2005 23:29:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] add EXPORT_SYMBOL for irq_exit
Message-Id: <20050106232959.693b637c.akpm@osdl.org>
In-Reply-To: <20050107071834.GA4168@osiris.boeblingen.de.ibm.com>
References: <20050107071834.GA4168@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> this patch adds the missing EXPORT_SYMBOL for irq_exit:
>  *** Warning: "irq_exit" [drivers/s390/net/iucv.ko] undefined!

Why do s/390 drivers call irq_exit()?
