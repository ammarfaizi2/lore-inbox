Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUC3ANp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbUC3ANp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:13:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:48291 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263324AbUC3ANj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:13:39 -0500
Date: Mon, 29 Mar 2004 16:15:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Siseci" <siseci@postmark.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x mount /dev/ram0 problem.
Message-Id: <20040329161548.05a36a18.akpm@osdl.org>
In-Reply-To: <BMEEKPMJDEAFABBKPBBNMELBCBAA.siseci@postmark.net>
References: <BMEEKPMJDEAFABBKPBBNMELBCBAA.siseci@postmark.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Siseci" <siseci@postmark.net> wrote:
>
> root@fen:~# umount /mnt
> root@fen:~# mount /dev/ram0 /mnt
> root@fen:~# ls -al /mnt
> total 17
> drwxr-xr-x   3 root     root         1024 Mar 29 20:28 ./
> drwxr-xr-x  22 root     root         4096 Dec 16 02:28 ../
> drwxr-xr-x   2 root     root        12288 Mar 29 20:28 lost+found/
> 
> My test file does not appear on /mnt.
> This was working with 2.4 kernels
> i think the problem is related with 2.6 kernels
> What is the problem?

It's a 2.6 bug which I haven't fixed yet.
