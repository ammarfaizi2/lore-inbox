Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVA0Wnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVA0Wnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVA0Wnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:43:39 -0500
Received: from web52302.mail.yahoo.com ([206.190.39.97]:52641 "HELO
	web52302.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261257AbVA0Wne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:43:34 -0500
Message-ID: <20050127224334.31954.qmail@web52302.mail.yahoo.com>
Date: Thu, 27 Jan 2005 23:43:34 +0100 (CET)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: 2.6.11-rc2-mm1: kernel bad access while booting diskless client
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050127142333.0ba81907.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Andrew Morton <akpm@osdl.org> escribió: 
> Can you tell us which filesystem is being bad?  Add
> this:
> 
> 	if (!inode->i_op)
> 		printk("%s is naughty\n", inode->i_sb->s_id);
> 
> It's probably NFS - there has been some work done in
> there in -mm.

0:a is naughty

Cheers,
Albert



		
______________________________________________ 
Renovamos el Correo Yahoo!: ¡250 MB GRATIS! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
