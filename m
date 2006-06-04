Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750715AbWFDTVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWFDTVN (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 15:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWFDTVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 15:21:13 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:21907 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750715AbWFDTVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 15:21:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=rjBElNiu0TIES7iKMJkvTCtAUjSCqnymdZZcPEQA35b3mL2j1N/9dpyhrAPcQnnFM8Sy2MYluMNRcrjrJLvYBB7SlOW9OKjjtoyWWFtAGmePPp3IMTUq2z26qH+eZfje2Cgzm+Asu5g/m/sxUqUDNxQcK3X4vfv1aoaDHtioTCU=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 2/8] UML - Define jmpbuf access constants
Date: Sun, 4 Jun 2006 20:19:59 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org> <a36005b50602071123r8179c7di8e95bf0a336f1b0c@mail.gmail.com> <20060208164301.GC5240@ccure.user-mode-linux.org>
In-Reply-To: <20060208164301.GC5240@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606042020.00120.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 17:43, Jeff Dike wrote:
> On Tue, Feb 07, 2006 at 11:23:42AM -0800, Ulrich Drepper wrote:
> > If you need this
> > functionality, implement it yourself.  setjmp is most likely overkill
> > anyway.
>
> OK, I'll roll my own version.

What about #ifdef'ing out the offending code #ifndef one of these constants 
(they'll be defined or not altogether). As expectable, this wasn't yet 
implemented - let's give the right priority to things.
(I've just met this on my SuSE, btw, which prompted me to write this email).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
