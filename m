Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVEXGsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVEXGsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 02:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVEXGst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 02:48:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:20097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261334AbVEXGsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 02:48:39 -0400
Date: Mon, 23 May 2005 23:50:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
In-Reply-To: <4292CB01.6090506@pobox.com>
Message-ID: <Pine.LNX.4.58.0505232349020.2307@ppc970.osdl.org>
References: <4292BA66.8070806@pobox.com> <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org>
 <4292CB01.6090506@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 May 2005, Jeff Garzik wrote:
> 
> You really can't beat
> 
> 	cp .git/refs/heads/master .git/refs/heads/new-branch
> 
> as the fastest way to create a new branch off the tip.

So? It's the fastest, but it's also BROKEN. Exactly because the way you do 
things, the merge messages are meaningless.

So fix your merge messages. 

		Linus
