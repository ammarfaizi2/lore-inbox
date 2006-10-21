Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992744AbWJUBm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992744AbWJUBm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 21:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992759AbWJUBm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 21:42:56 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:54908 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S2992744AbWJUBmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 21:42:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Fobq+2JUqfAOddHiKqG+8rerEWz8hrHArZddrgXMX1rnQ5NeV19OG9VhF3AmrRLUjiFXdcuhVhsg9jsrtTTN9XHBY6az+YqkRV5mfajeZiKqrAVmIYri/IlQlkfJbovdhw6wMPaizUDn5LXIltXCbXfKJkvw3IRpKirMR2Vw3hg=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 03/10] uml: fix prototypes
Date: Sat, 21 Oct 2006 03:42:47 +0200
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan> <20061017212709.26445.54420.stgit@americanbeauty.home.lan> <20061018183222.GA6566@ccure.user-mode-linux.org>
In-Reply-To: <20061018183222.GA6566@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610210342.48107.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 20:32, Jeff Dike wrote:
> On Tue, Oct 17, 2006 at 11:27:09PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Fix prototypes in user.h - was needed when including user.h in
> > kernelspace, as we did in previous patch.
>
> user.h shouldn't be included in kernelspace - its purpose is to
> provide kernel prototypes to userspace code.
Actually I now think (and just verified) I do not even include it any more in 
kernelspace - that comment is outdated. Having a more correct prototype is 
anyway nicer, so that patch can go in with a rewritten changelog (but that's 
a taste matter). I'm rewriting it anyway.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
