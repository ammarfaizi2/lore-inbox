Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbUJ1Jee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbUJ1Jee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbUJ1JcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:32:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:16554 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262853AbUJ1Jbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:31:48 -0400
Date: Thu, 28 Oct 2004 02:29:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: dan@fullmotions.com, linux-kernel@vger.kernel.org
Subject: Re: SSH and 2.6.9
Message-Id: <20041028022942.7ef1a8b8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0410280034020.3284@dragon.hygekrogen.localhost>
References: <1098906712.2972.7.camel@hanzo.fullmotions.com>
	<Pine.LNX.4.61.0410272247460.3284@dragon.hygekrogen.localhost>
	<1098912301.4535.1.camel@hanzo.fullmotions.com>
	<1098913797.3495.0.camel@hanzo.fullmotions.com>
	<Pine.LNX.4.61.0410280034020.3284@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> Now I guess we just need for someone to find out why LEGACY_PTYS breaks 
>  ssh (and other apps?) with kernels >= 2.6.9,

Works OK here, witht he latest of everything.  Please send the faulty
.config.

If you could generate the `strace -f' output from good and bad
sessions and identify where things went wrong, that would help.

