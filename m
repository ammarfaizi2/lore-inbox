Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275427AbTHIXMT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 19:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275434AbTHIXMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 19:12:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:20911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275427AbTHIXMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 19:12:18 -0400
Date: Sat, 9 Aug 2003 16:12:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new dev_t printable convention and lilo
Message-Id: <20030809161221.1a94eb2c.akpm@osdl.org>
In-Reply-To: <200308100218.51271.arvidjaar@mail.ru>
References: <200308100218.51271.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>
> {pts/2}% cat /proc/cmdline
> BOOT_IMAGE=260-t3smp2 ro root=345 devfs=mount
> 
> I guess it has to use 03:45 now? Does it mean lilo has to be updated to handle 
> new convention?
> 

I think we need to teach the parsing code to handle both styles.

It's a bit of a screwup.
