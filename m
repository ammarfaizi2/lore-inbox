Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWJQQy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWJQQy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWJQQy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:54:26 -0400
Received: from pat.uio.no ([129.240.10.4]:749 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751321AbWJQQyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:54:25 -0400
Subject: Re: [REGRESSION] nfs client: Read-only file system (2.6.19-rc1,2)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <4534F59D.4040505@gmail.com>
References: <4534F59D.4040505@gmail.com>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 12:54:11 -0400
Message-Id: <1161104051.5559.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.802, required 12,
	autolearn=disabled, AWL 1.20, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 17:24 +0200, Jiri Slaby wrote:
> Hi!
> 
> I can't write on mounted nfs filesystem since 2.6.19-rc1 (nfs client):
> touch: cannot touch `aaa': Read-only file system
> 
> strace says:
> open("aaa", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) = -1 EROFS 
> (Read-only file system)
> 
> 2.6.18 behaves correctly. Settings are the same, does anybody have any clue?
> 
> regards,

What does "cat /proc/mounts" say?

