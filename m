Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVKUUkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVKUUkH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVKUUkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:40:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932279AbVKUUkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:40:05 -0500
Date: Mon, 21 Nov 2005 12:39:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: cel@citi.umich.edu, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
Message-Id: <20051121123950.5afadab9.akpm@osdl.org>
In-Reply-To: <20051121184032.80469.qmail@web34101.mail.mud.yahoo.com>
References: <438208A1.5020300@citi.umich.edu>
	<20051121184032.80469.qmail@web34101.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenny Simpson <theonetruekenny@yahoo.com> wrote:
>
> ext3 doesn't let you use pwrite with O_DIRECT

ext3 does permit that.  See odwrite.c from
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
