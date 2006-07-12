Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWGLLBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWGLLBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWGLLBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:01:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31132 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751224AbWGLLBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:01:21 -0400
Subject: Re: tty's use of file_list_lock and file_move
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Theodore Tso <tytso@mit.edu>, Jon Smirl <jonsmirl@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f020607112327y48d9cccueb4c5e3904d6981@mail.gmail.com>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <20060710233944.GB30332@thunk.org>
	 <84144f020607112327y48d9cccueb4c5e3904d6981@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 12:19:20 +0100
Message-Id: <1152703160.22943.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-12 am 09:27 +0300, ysgrifennodd Pekka Enberg:
> How is this supposed to work? What's stopping a process from
> re-opening the file after revoke(2) has been called?

File permissions.


