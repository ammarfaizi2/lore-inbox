Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTFJLlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 07:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTFJLlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 07:41:46 -0400
Received: from kempelen.iit.bme.hu ([152.66.241.120]:6876 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S262316AbTFJLlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 07:41:42 -0400
Date: Tue, 10 Jun 2003 13:55:22 +0200 (MET DST)
From: =?ISO-8859-2?Q?P=E1sztor_Szil=E1rd?= <silicon@inf.bme.hu>
To: linux-kernel@vger.kernel.org
cc: linux-net@vger.kernel.org, Adrian Bunk <bunk@fs.tum.de>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [2.5 patch] let COMX depend on PROC_FS
In-Reply-To: <20030608175850.A9513@infradead.org>
Message-ID: <Pine.GSO.4.00.10306101347450.1700-100000@kempelen.iit.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig:
> > The proc_get_inode link problem only affects the modular build of 
> > comx.c .
> 
> But it's still broken :)  This just shows no one actually tested
> it with actual hardware.

I'm the current "maintainter" of the comx drivers (seriously lacked time up
to now), so it's me to flame if you have some spare fuel. And forgive me for
having forgot to update the maintainer line in comx.c (comx-* are fine). :)

The drivers are used by some hundreds of cards today but we tell users to
get the small kernelpatch from www.itc.hu and the patch, among other things,
exports proc_get_inode. There was a process to integrate the patch into the
mainstream kernel last year but, due to lack of time on my part, it was
suspended. I hope to be able to pick the line up again and clean things up.

s.
          ------------------------------------------------------------
          |  Programmers don't die, they just GOSUB without RETURN.  |
          ------------------------------------------------------------

