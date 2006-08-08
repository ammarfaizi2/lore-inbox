Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWHHKqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWHHKqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWHHKqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:46:34 -0400
Received: from web25224.mail.ukl.yahoo.com ([217.146.176.210]:13494 "HELO
	web25224.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964778AbWHHKqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:46:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=EXllRKcXAqHE4huvUbT+Nxme3tgh4ksYhQaSEOuPZDZkGix9d9awy8GBdnegkQJCqn0n2COtV2Cf2XtNSAzpUqlEbU8iwIwBh0ZKHQBFH1WhpAB9XSt9RFr06lvEpxOipPAN9zY3ynMQooQU76Nof/Exgry4F9PVWk10bnV8IzY=  ;
Message-ID: <20060808104605.6696.qmail@web25224.mail.ukl.yahoo.com>
Date: Tue, 8 Aug 2006 12:46:05 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060807211850.GB5890@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Sun, Aug 06, 2006 at 05:47:00PM +0200, Paolo 'Blaisorblade'
> Giarrusso wrote:
> > +_extra_flags_ = -fno-builtin -m64 -mcmodel=kernel

> What exactly does this do
go to "man gcc" and search mcmodel for the answer to this one.
And x86_64 uses it too, so this patch should go for 2.6.18.

>, and can you remember why you think it's
> needed?

Ok, here's my answer to the original bugreport, which is a complete
explaination - sorry for not providing the link, I have very little
time for UML this summer.

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=115125101012707&w=2

Bye

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
