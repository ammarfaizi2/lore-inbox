Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269313AbUICQbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269313AbUICQbN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269436AbUICQax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:30:53 -0400
Received: from the-village.bc.nu ([81.2.110.252]:50068 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269420AbUICQ33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:29:29 -0400
Subject: Re: [PATCH] tidy AMD 768MPX fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andy Whitcroft <apw@shadowen.org>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1C3GhJ-0001YB-7N@localhost.localdomain>
References: <E1C3GhJ-0001YB-7N@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094225233.8102.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 16:27:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 17:13, Andy Whitcroft wrote:
> Convert the AMD 768MPX errata #56 fix to use PAGE_SIZE instead of using
> 4096 in line with other declarations in this file.  Also take the
> oppotunity to match indentation.

Even if we use a different software page size in some future x86 release
the workaround is to reserve 4096 bytes. I don't think this change makes
sense therefore.

