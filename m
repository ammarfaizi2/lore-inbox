Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262145AbREPXmM>; Wed, 16 May 2001 19:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262143AbREPXmC>; Wed, 16 May 2001 19:42:02 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37133 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262142AbREPXlx>; Wed, 16 May 2001 19:41:53 -0400
Subject: Re: [PATCH] rootfs (part 1)
To: cr@sap.com (Christoph Rohland)
Date: Thu, 17 May 2001 00:37:44 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <m3wv7h5p7q.fsf@linux.local> from "Christoph Rohland" at May 16, 2001 04:43:37 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150ArQ-0004dj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why do you use ramfs? Most of it is duplicated in tmpfs and ramfs is a
> minimal _example_ fs. There was some agreement that this should stay
> so.

I think ramfs is an incredibly flawed example right now - precisely because
it has no error cases. ramfs with the size limiting is a brilliant fs for
embedded/pda work as well as an example that shows error paths


