Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUIORLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUIORLG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266646AbUIORJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:09:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:13231 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266884AbUIORHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:07:42 -0400
Date: Wed, 15 Sep 2004 10:07:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
In-Reply-To: <20040915165450.GD6158@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Sep 2004, Jörn Engel wrote:
> 
> C now supports pointer arithmetic with void*?

C doesn't. gcc does. It's a documented extension, and it acts like if it 
was done on a byte.

See gcc's user guide "Extension to the C Language Family".

It's a singularly good feature. 

		Linus
