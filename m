Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUBKD7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 22:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUBKD7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 22:59:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:28067 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262123AbUBKD7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 22:59:36 -0500
Date: Tue, 10 Feb 2004 20:02:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Critical problem in 2.6.2 and up
Message-Id: <20040210200220.32329bfd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402110350240.28596@student.dei.uc.pt>
References: <Pine.LNX.4.58.0402110250580.28596@student.dei.uc.pt>
	<20040210191911.4d6e1308.akpm@osdl.org>
	<Pine.LNX.4.58.0402110325050.28596@student.dei.uc.pt>
	<Pine.LNX.4.58.0402110350240.28596@student.dei.uc.pt>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:
>
> 
> With nbd disabled the patch causes no problems.
> 

I don't know what LILO's problem is, frankly.  My version is OK with it,
and my /proc/partitions is doing the same as yours.

vmm:/home/akpm>  lilo -V       
LILO version 21.4-4

Still, we probably want to suppress all those NDB majors in
/proc/partitions.  I'll discuss it with the blocky guys.

