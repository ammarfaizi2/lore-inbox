Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUJOTog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUJOTog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUJOTof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:44:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11216 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268339AbUJOToG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:44:06 -0400
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <416FB275.6425.1C3D985@localhost>
References: <416E8322.25700.29ACC2F1@localhost>
	 <416FB275.6425.1C3D985@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097865683.10132.190.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Oct 2004 19:41:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-15 at 19:20, Kendall Bennett wrote:
> Also I assume the code would need to end up in the initrg image, correct? 
> Can you point me at some resources to learn more about how to get custom 
> code into the initrd image?

Just roll whatever you want into it. Its a file system that is your
initial root fs and is then swapped to appear under a file system it
mounts (and finally potentially is freed).

Something like the Red Hat "mkinitrd" ought to give you a good flavour
of what you can do with it.

