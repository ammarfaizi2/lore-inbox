Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTKJNTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbTKJNTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:19:23 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:30440 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263553AbTKJNTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:19:22 -0500
Date: Mon, 10 Nov 2003 14:19:11 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Tomasz Chmielewski <mangoo@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compressed tmpfs
Message-ID: <20031110131911.GA12099@wohnheim.fh-wedel.de>
References: <3FAF894C.4040806@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FAF894C.4040806@interia.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 November 2003 13:49:16 +0100, Tomasz Chmielewski wrote:
> 
> I was looking for something like tmpfs, but with additional feature - 
> that all the files in that file system would be compressed.
> 
> I think it could be nice for one's RAM, especially in embedded 
> devices/diskless stations, at a little expense of efficiency.
> 
> Is there such a feature in 2.4 kernel yet, and, if not, where should I 
> look for it?
> 
> There is e2compr module on http://sourceforge.net/projects/e2compr/, but 
> I'm not sure if it can be easily applied to 2.4.22 kernel (seems like 
> it's for 2.4.17 kernels only).

Jffs2 on a ramdisk comes close to what you want.  For something
better, you have to code it up yourself.

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
