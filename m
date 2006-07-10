Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422713AbWGJRPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbWGJRPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWGJRPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:15:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46289 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422713AbWGJRPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:15:33 -0400
Subject: Re: tty's use of file_list_lock and file_move
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 18:33:26 +0100
Message-Id: <1152552806.27368.187.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 11:10 -0400, ysgrifennodd Jon Smirl:
> Since you want a new subject can you explain tty's use of file_lock to
> me? Is there some non-obvious global coordination happening here or is
> it work breaking down the big kernel lock that never got finished?

Its explained in the comment in do_SAK.

Alan

