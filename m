Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVFFVLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVFFVLe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVFFVLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:11:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:17027 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261656AbVFFVLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:11:11 -0400
Date: Mon, 6 Jun 2005 14:13:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
In-Reply-To: <20050606201441.GG2230@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0506061411410.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
 <20050606192654.GA3155@elf.ucw.cz> <Pine.LNX.4.58.0506061310500.1876@ppc970.osdl.org>
 <20050606201441.GG2230@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Jun 2005, Pavel Machek wrote:
> 
> There is "From: Dmitry..." in the changelog. Do your script move first
> "From:" into author header and delete it from changelog? That would
> explain it...

Yes. But note how it doesn't even take the "first" From: line, it 
literally takes the From: line _only_ if that line is the first line in 
the email body.

See the "git-tools" archive if you want to see all the ugly details (start 
from http://www.kernel.org/git)

		Linus
