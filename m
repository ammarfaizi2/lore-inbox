Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbTHWIZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 04:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbTHWIZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 04:25:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:46812 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261963AbTHWIZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 04:25:58 -0400
Date: Sat, 23 Aug 2003 01:28:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Siim Vahtre <siim@pld.ttu.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cryptoloop bug with 2.6.0-test3
Message-Id: <20030823012807.63e60163.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.53.0308231109170.20934@pitsa.pld.ttu.ee>
References: <Pine.GSO.4.53.0308231109170.20934@pitsa.pld.ttu.ee>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siim Vahtre <siim@pld.ttu.ee> wrote:
>
> siim@void:/boot$ sudo rmmod twofish crypto_null des serpent aes cryptoloop loop
> 
>  Unable to handle kernel paging request at virtual address 19000040

This should be fixed in test4.
