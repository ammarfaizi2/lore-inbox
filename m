Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265058AbUFAOWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbUFAOWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265072AbUFAOVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:21:53 -0400
Received: from aun.it.uu.se ([130.238.12.36]:32252 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265058AbUFAOTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:19:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16572.36993.237361.960475@alkaid.it.uu.se>
Date: Tue, 1 Jun 2004 16:19:45 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-rc2] gcc-3.4.0 warning in i386 __down_read_trylock()
In-Reply-To: <Pine.LNX.4.58.0405301021480.1632@ppc970.osdl.org>
References: <200405301047.i4UAl5Wg003268@harpo.it.uu.se>
	<Pine.LNX.4.58.0405301021480.1632@ppc970.osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > 
 > On Sun, 30 May 2004, Mikael Pettersson wrote:
 > >
 > > The i386 __down_read_trylock() code contains a "+m" asm
 > > constraint, which triggers warnings from gcc-3.4.0:
 > 
 > This comes up every once in a while.
 > 
 > It's going to be fixed in 3.4.1, and the 3.4.0 warning is just bogus.

Ok, I see. But most "+m" constraints in the i386 arch files
have already been "fixed"; the one I sent is I think the
last one. Should those "fixes" be undone?

/Mikael
