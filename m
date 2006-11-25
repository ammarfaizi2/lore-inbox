Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757934AbWKYQDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934AbWKYQDk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757935AbWKYQDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:03:40 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65486 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757934AbWKYQDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:03:39 -0500
Date: Sat, 25 Nov 2006 16:09:54 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Casey Dahlin <cjdahlin@ncsu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Overriding X on panic
Message-ID: <20061125160954.239e0d7e@localhost.localdomain>
In-Reply-To: <1164434093.10503.2.camel@localhost.localdomain>
References: <1164434093.10503.2.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006 00:54:53 -0500
Casey Dahlin <cjdahlin@ncsu.edu> wrote:

> Linus did say that he would do anything within reason to help desktop
> linux forward, and frankly a big step forward would be to get error
> messages to the user. What might be some safe options for overriding,
> switching away from, killing, or otherwise disposing of the X server
> when an unrecoverable Oops is about to occur on the TTY?

Assuming frame buffer support is present in the kernel you need an ioctl
that specifies the frame buffer depth/layout so the kernel can print
correctly on it. At that point most of the time you'll get the report out
- more than trying to mode switch probably.

Send patches

Alan
