Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965312AbWGJW5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbWGJW5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965313AbWGJW5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:57:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48611 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965312AbWGJW5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:57:17 -0400
Subject: Re: tty's use of file_list_lock and file_move
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 00:15:11 +0100
Message-Id: <1152573312.27368.212.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 18:35 -0400, ysgrifennodd Jon Smirl:
> Assuming do_SAK has blocked anyone's ability to newly open the tty,
> why does it need to search every file handle in the system instead of
> just using tty->tty_files? tty->tty_files should contain a list of
> everyone who has the tty open. Is this global search needed because of
> duplicated handles?

I don't actually know. Thats an area I've not dug too deeply into at
all. 

