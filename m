Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUDEVvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUDEVvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:51:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:53472 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263372AbUDEVt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:49:59 -0400
Date: Mon, 5 Apr 2004 14:52:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Angelo Dell'Aera" <buffer@antifork.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.5-mm1 : laptop-mode
Message-Id: <20040405145209.4904aec5.akpm@osdl.org>
In-Reply-To: <20040405155055.3e9afab0.buffer@antifork.org>
References: <20040405155055.3e9afab0.buffer@antifork.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Angelo Dell'Aera" <buffer@antifork.org> wrote:
>
> After upgrading to 2.6.5-mm1 I noticed the script laptop_mode
> failed to initiliaze laptop mode. It is due to the new position
> of the sysctl laptop_mode under /proc. This is an update to the
> documentation (and the script). Please apply.
> ...
>  
> -Laptop-mode is controlled by the flag /proc/sys/vm/laptop_mode. When this
> +Laptop-mode is controlled by the flag /proc/sys/fs/laptop_mode. When this

erk.  No, that was not intended.  Looks like `patch' decided to move some code around
for me.  I'll fix that up, thanks.  laptop_mode shall remain in /proc/sys/vm/
