Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbUKMAkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbUKMAkn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUKMAgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:36:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:43904 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262748AbUKMAeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 19:34:25 -0500
Date: Fri, 12 Nov 2004 16:36:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2 DIO failures
Message-Id: <20041112163647.73c0ebd8.akpm@osdl.org>
In-Reply-To: <419553B3.7000802@us.ibm.com>
References: <419553B3.7000802@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I see LTP DIO test failures on 2.6.10-rc1-mm2 while doing
> direct-IO write to filesystem files.

Fixed in -mm5.  See
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/readpage-vs-invalidate-fix.patch

