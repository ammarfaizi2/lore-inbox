Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUE3RWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUE3RWo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbUE3RWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:22:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:4264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264213AbUE3RWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:22:43 -0400
Date: Sun, 30 May 2004 10:22:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-rc2] gcc-3.4.0 warning in i386 __down_read_trylock()
In-Reply-To: <200405301047.i4UAl5Wg003268@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.58.0405301021480.1632@ppc970.osdl.org>
References: <200405301047.i4UAl5Wg003268@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 May 2004, Mikael Pettersson wrote:
>
> The i386 __down_read_trylock() code contains a "+m" asm
> constraint, which triggers warnings from gcc-3.4.0:

This comes up every once in a while.

It's going to be fixed in 3.4.1, and the 3.4.0 warning is just bogus.

		Linus
