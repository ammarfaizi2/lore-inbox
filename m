Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266409AbUG2Gs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUG2Gs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 02:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUG2Gs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 02:48:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:35762 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264492AbUG2Gsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 02:48:55 -0400
Date: Thu, 29 Jul 2004 08:48:13 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix zlib debug in ppc boot header
Message-ID: <20040729064813.GB17282@suse.de>
References: <20040728112222.GA7670@suse.de> <1091014495.2795.25.camel@laptop.fenrus.com> <20040728150145.GK10891@smtp.west.cox.net> <20040728153633.GA21105@suse.de> <20040728230635.GC16468@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040728230635.GC16468@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jul 28, Tom Rini wrote:

> On Wed, Jul 28, 2004 at 05:36:33PM +0200, Olaf Hering wrote:
> 
> > 
> >  On Wed, Jul 28, Tom Rini wrote:
> > 
> > > Olaf, has having this code work for you ever been useful?  Thanks.
> > 
> > The debug stuff? Sure. Now I know we have to improve the memcpy
> > alignment handling. But thats a different story.
> 
> Can you please elaborate?  Thanks.

ppc 601 barfs on unaligned string instructions. we can handle the
exceptions when the kernel runs, but not when OF is still in charge.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
