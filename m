Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbTACEZR>; Thu, 2 Jan 2003 23:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTACEZR>; Thu, 2 Jan 2003 23:25:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15881 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267374AbTACEZR>; Thu, 2 Jan 2003 23:25:17 -0500
Date: Thu, 2 Jan 2003 20:28:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] Module licence and EXPORT_SYMBOL_GPL
In-Reply-To: <20030103042650.68E102C0B0@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0301022025200.1700-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 3 Jan 2003, Rusty Russell wrote:
> 
> Linus, your options:
> 1) Drop the patch and leave well enough alone.
> 2) Just keep the module licence taint check.
> 3) Say OK to the whole thing (once I've tested it against latest bk).

Hmm.. Can you make the "module_is_gpl()" thing a load-time check, and 
instead of carrying the license string along at run-time, you just carry 
the "I'm GPL-ok'd" bit along. 

		Linus

