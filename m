Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbTHZF4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTHZF4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:56:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:2440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262696AbTHZF4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:56:04 -0400
Date: Mon, 25 Aug 2003 22:58:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bryan Ballard <ballard@netsolus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting problem with 450NX based Compaq server
Message-Id: <20030825225820.2d1c6e29.akpm@osdl.org>
In-Reply-To: <1061875433.24196.15.camel@ant>
References: <1061875433.24196.15.camel@ant>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Ballard <ballard@netsolus.com> wrote:
>
> Hello, I've looked through the kernel list archives and haven't found
>  anything that might help. I have a Compaq 5500r 4x500mhz Xeons and
>  whenever a heavy load is placed on the box it reboots without any kernel
>  panics or oops. It seems to be related primarily to multiple PCI card
>  access, i.e. during heavy RAID card / NIC interaction. I've tried to
>  isolate it by replacing NICs and RAID cards, but the only thing I can
>  come up with is that it is related to the 450NX chipset. 
>  Since I am not sure anyone is still working on the 450NX chipset I've
>  refrained from cluttering the list with a giant E-mail full of /proc
>  data until someone answers back that they would be interested in any
>  information that I can provide them.

I have an Intel ad450nx server, based on the 450NX PCISet chipset. 
4x500MHz Xeons.  It runs like a champ.

Maybe you have a buggy kernel.  Try a vendor patch, or switch vendors,
or try a kernel.org kernel or something like that?
