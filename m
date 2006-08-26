Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422963AbWHZK4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422963AbWHZK4s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 06:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWHZK4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 06:56:48 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:11136 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030193AbWHZK4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 06:56:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ttvYlKbWYsdhAz3qTm/hIJ+egYOvHh11hda5t0jryJQhJsy+DzqCH6OVIjyr0n5o5OWah3zwZXHv0oU+4ubXThYKndJ07TGnkHYn9Ip1Cvc/JmkxcZvKE1jWmP8GCZxxCM6SjnqTB2Loqwwz0PmeQmHLNTdXX11JMUfuxNmIuDI=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
Date: Sat, 26 Aug 2006 12:56:36 +0200
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, jdike@karaya.com,
       linux-kernel@vger.kernel.org
References: <20060821215641.GQ11651@stusta.de>
In-Reply-To: <20060821215641.GQ11651@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608261256.36654.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 August 2006 23:56, Adrian Bunk wrote:
> arch/um/sys-i386/setjmp.S contains two #ifdef _REGPARM's.
>
> Even if regparm was used in i386 uml (which isn't currently done (why?)),
> I don't see _REGPARM being defined anywhere.
>
> Is this a bug waiting for happening when regparm will be used on uml or
> do I miss anything?
Can anybody explain me how can we use REGPARM if we have to link with host 
glibc?
If we are going to use klibc instead of glibc that's ok (and this is not the 
case I'm talking about), but I do not know that plan (and nobody discussed 
the implications).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
