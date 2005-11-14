Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVKNBE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVKNBE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 20:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVKNBE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 20:04:29 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:26142 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750807AbVKNBE2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 20:04:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gTk4I18Qqtkfe1xN+0RKzBKl6X99LfR6p9vcA4YH9tU/d8QIUTrBj/KPCQMhe0KdansDoJ9g93w1lU4ntrq9GZ0UivPoz+2/pCefKhQP6yNTtyxp6NxHNMZrWEIIe1nX3+tLdONjQG5GAeQzJeS/5bOsz0Qjfu/nHLuygfPDE5g=
Message-ID: <9a8748490511131704m18dcfa37re8100b469388fe3c@mail.gmail.com>
Date: Mon, 14 Nov 2005 02:04:28 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Michael Buesch <mbuesch@freenet.de>
Subject: Re: Linuv 2.6.15-rc1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200511122237.17157.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <200511122145.38409.mbuesch@freenet.de>
	 <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	 <200511122237.17157.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/05, Michael Buesch <mbuesch@freenet.de> wrote:
> On Saturday 12 November 2005 22:00, you wrote:
> >
> > On Sat, 12 Nov 2005, Michael Buesch wrote:
> > >
> > > Latest GIT tree does not boot on my G4 PowerBook.
> >
> > What happens if you do
> >
> >       make ARCH=powerpc
> >
> > and build everything that way (including the "config" phase)?
>
> I did
> make mrproper
> copy the .config over again

are you not missing a "make oldconfig" step here?

> make ARCH=powerpc menuconfig


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
