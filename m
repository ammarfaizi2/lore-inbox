Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267328AbUHIWk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267328AbUHIWk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUHIWk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:40:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:47059 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267328AbUHIWkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:40:21 -0400
Subject: Re: [PATCH] Remove unneeded #ifdef kernel from ppc unaligned.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: GOTO Masanori <gotom@debian.or.jp>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <81pt60680s.wl@omega.webmasters.gr.jp>
References: <81smaw6gd2.wl@omega.webmasters.gr.jp>
	 <1092038864.14100.42.camel@gaston>  <81pt60680s.wl@omega.webmasters.gr.jp>
Content-Type: text/plain
Message-Id: <1092091050.14102.50.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 08:37:31 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 18:16, GOTO Masanori wrote:
> At Mon, 09 Aug 2004 18:07:45 +1000,
> Benjamin Herrenschmidt wrote:
> > On Mon, 2004-08-09 at 15:16, GOTO Masanori wrote:
> > > This patch removes unneeded #ifdef __KERNEL__ from ppc unaligned.h.
> > > There's no reason to enclose __KERNEL__, similar to other
> > > architectures.  It also fixes the compilation failure building
> > > userland helper application reiserfsprogs on ppc which includes
> > > asm/unaligned.h.
> > 
> > Well, userland isn't supposed to use those ...
> 
> I know.  It's just side effect.  But there's no reason to enclose
> #ifdef __KERNEL__.

Hrm... I'd say there is no reason not to enclose it in it, but I'll
let Paul make a final decision here.

Ben.


