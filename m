Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263145AbVG3TpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbVG3TpT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbVG3Tnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:43:31 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:8356 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263144AbVG3TmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:42:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=4IEP2/hZTTJq3/2y1hDFlQEW9T6uOjjwZpEbHjzxiIXYFKnVUviO5N6+K0XD8mjPj0731V6c6zRYURfsq5RDuxaVQlxN8uMfCZ8J3f+qlyGWPj0RgP6/wEgwMUjCe78T/DeZjL19leow9vw6EMzMtitz26bF0iBa3SbSKDr+5A0=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 1/3] uml: add dwarf sections to static link script
Date: Sat, 30 Jul 2005 21:47:05 +0200
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050730190534.6FB5B843@zion.home.lan> <20050730193532.GA19768@mars.ravnborg.org>
In-Reply-To: <20050730193532.GA19768@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507302147.06440.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 July 2005 21:35, Sam Ravnborg wrote:
> On Sat, Jul 30, 2005 at 09:05:33PM +0200, blaisorblade@yahoo.it wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Inside the linker script, insert the code for DWARF debug info sections.
> > This may help GDB'ing a Uml binary. Actually, it seems that ld is able to
> > guess what I added correctly, but normal linker scripts include this
> > section so it should be correct anyway adding it.

> Can we please have this added to include/asm-generic/vmlinux.lds.h so we
> can share the definition.
Hmm, I'm going to leave for now, so I won't be able to handle this soon. If 
you can do that it'd be nice. Thanks and sorry for this request.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
