Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUJOWpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUJOWpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUJOWpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:45:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:54760 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266603AbUJOWnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:43:33 -0400
Date: Fri, 15 Oct 2004 15:42:16 -0700
From: Greg KH <greg@kroah.com>
To: eshwar <eshwar@moschip.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any way to find which pci driver uses what memory region & Any way to find which driver is attached to which device file
Message-ID: <20041015224216.GA30319@kroah.com>
References: <02a001c4b74a$4442ade0$41c8a8c0@Eshwar> <02d101c4b74b$a204cbb0$41c8a8c0@Eshwar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d101c4b74b$a204cbb0$41c8a8c0@Eshwar>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 02:24:54PM +0530, eshwar wrote:
> 
> HI,
> 
>  Is there any way to find which pci driver uses what memroy regions

cat /proc/iomem

> and any way to find which driver si attached to which device file

Through the symlinks in /sys/

good luck,

greg k-h
