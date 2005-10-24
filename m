Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbVJXXBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVJXXBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 19:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVJXXBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 19:01:54 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:11363 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750897AbVJXXBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 19:01:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=4sytmhxgd6eiYCOtwV6VSHED2zhrGVcR1kV51jbaw85IRLSq3fJGMSlLGpsX/raql8LRF3g0w5Ngfwr6YW17aUaZHxnt6KwkBMh9kXBjrvWfcStVeIx2U6ncA8rm8Pq0DYNYUm/SW8/0Qu7Y6DEZjp0beJlsJSOdb5bBm7eqKao=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.14-rc5-mm1] UML: fix compile part-1
Date: Tue, 25 Oct 2005 01:05:39 +0200
User-Agent: KMail/1.7.2
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       jdike@addtoit.com
References: <E1EU4es-0005l0-00@dorka.pomaz.szeredi.hu> <20051024153534.62315410.akpm@osdl.org>
In-Reply-To: <20051024153534.62315410.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510250105.45505.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 October 2005 00:35, Andrew Morton wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> > --- linux.orig/arch/um/include/sysdep/syscalls.h	2005-10-04
> > 14:18:29.000000000 +0200 +++
> > linux/arch/um/include/sysdep/syscalls.h	2005-10-04 14:19:07.000000000
> > +0200
>
> The patch didn't apply - arch/um/include/sysdep is a symlink, so it has the
> same problem as patches against include/asm/*.
Using O= in the build helps avoiding this problems (beyond lots of other 
niceties).
> You really weanted to patch arch/um/include/sysdep-i386/syscalls.h
Yep.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
