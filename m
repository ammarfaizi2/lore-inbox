Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbTDOOlw (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTDOOlw 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:41:52 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:15366 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S261584AbTDOOlv (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 10:41:51 -0400
Date: Tue, 15 Apr 2003 16:53:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <UTC200304151404.h3FE4AY07391.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0304151651280.5042-100000@serv>
References: <UTC200304151404.h3FE4AY07391.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
On Tue, 15 Apr 2003 Andries.Brouwer@cwi.nl wrote:

> > BTW there are a few more functions missing, we need a dev_to_u32()
> > and a dev_to_u16(), so e.g. file systems can do something useful
> > in mknod if they can't store the complete number.
> 
> In such cases I cannot see any meaningful action other than returning
> EOVERFLOW (or EINVAL in case you prefer that).

Yes, that's what I had in mind.

bye, Roman

