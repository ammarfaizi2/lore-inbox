Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271068AbUJVPHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271068AbUJVPHU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271329AbUJVPHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:07:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:45257 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271068AbUJVPHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:07:18 -0400
Date: Fri, 22 Oct 2004 08:07:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Kara <jack@suse.cz>
cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] Quota warnings somewhat broken
In-Reply-To: <20041022093423.GC31932@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.58.0410220804040.2101@ppc970.osdl.org>
References: <Pine.LNX.4.53.0410211807020.12823@yvahk01.tjqt.qr>
 <20041022093423.GC31932@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Oct 2004, Jan Kara wrote:
>
>   Thanks for notifying. It looks like a good idea. Attached patch should apply
> well to 2.6.9. Linus, please apply.

Why does this code use tty_write_message() in the first place? It's a bit 
rude to mess up the users tty without any way to disable it, isn't it? 

		Linus
