Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266240AbUFPLJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUFPLJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 07:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266241AbUFPLJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 07:09:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:15082 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266240AbUFPLJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 07:09:54 -0400
Date: Wed, 16 Jun 2004 13:00:51 +0200
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: remove duplicate COMPATIBLE_IOCTL lines
Message-Id: <20040616130051.7b8fe3e1.ak@suse.de>
In-Reply-To: <200406111510.37981.arnd@arndb.de>
References: <200406111510.37981.arnd@arndb.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2004 15:10:37 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Some of the ioctl numbers in ia32_ioctl are already defined in
> include/linux/compat_ioctl.h, so they can be removed here.
> Maybe we should have a runtime check for duplicate numbers?
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks. Your patch was corrupted somehow, but I applied it by
hand.

-Andi
