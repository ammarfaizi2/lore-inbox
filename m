Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbTDDSuP (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTDDSuP (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:50:15 -0500
Received: from [12.47.58.55] ([12.47.58.55]:37128 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263900AbTDDSuN (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:50:13 -0500
Date: Fri, 4 Apr 2003 11:02:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: K-MailNet@yandex.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about buffer_head
Message-Id: <20030404110232.13fec396.akpm@digeo.com>
In-Reply-To: <3E8D692F.000004.30743@ariel.yandex.ru>
References: <3E8D692F.000004.30743@ariel.yandex.ru>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2003 19:01:37.0800 (UTC) FILETIME=[9E74D080:01C2FADC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"K-MailNet" <K-MailNet@yandex.ru> wrote:
>
> Hi ,
> Could anybody explain me what this list content
> 
> buffer_head->b_assoc_buffers
> 
> In the kenel's  coments is writen  /* associated with another mapping */
> I can't  clearly understand it
> Does it contents others buffer_heads of the page or thomething else?
> 

There are some comments in fs/buffer.c (search for b_assoc_buffers)
and also this changelog:

http://linux.bkbits.net:8080/linux-2.5/user=akpm/cset@1.373.169.4?nav=!-|index.html|stats|!+|index.html|ChangeSet@-2y
