Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTGFS5T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 14:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266714AbTGFS5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 14:57:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6380 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263250AbTGFS5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 14:57:18 -0400
Message-ID: <3F08746C.6010803@pobox.com>
Date: Sun, 06 Jul 2003 15:11:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4 direct_IO API changing?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see in 2.4.22-BK-latest:

> -       int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
> +       int (*direct_IO)(int, struct file *, struct kiobuf *, unsigned long, int


Should this really be changing in the middle of a stable series?

I realize that vendor's are already shipping this difference, but 
still...  it's a bit of an abrupt midseries change that can potentially 
break working code.

	Jeff



