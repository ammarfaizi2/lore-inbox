Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267686AbRGPTkB>; Mon, 16 Jul 2001 15:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267691AbRGPTju>; Mon, 16 Jul 2001 15:39:50 -0400
Received: from AMontpellier-201-1-2-148.abo.wanadoo.fr ([193.253.215.148]:65292
	"EHLO awak") by vger.kernel.org with ESMTP id <S267686AbRGPTjk>;
	Mon, 16 Jul 2001 15:39:40 -0400
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jeff Hartmann <jhartmann@valinux.com>
Cc: John Cavan <johnc@damncats.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3B53413A.6060501@valinux.com>
In-Reply-To: <E15M6jC-0005PK-00@the-village.bc.nu>
	<3B532BB7.1050300@valinux.com> <3B533578.A4B6C25F@damncats.org> 
	<3B53413A.6060501@valinux.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 16 Jul 2001 21:34:48 +0200
Message-Id: <995312089.987.8.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jul 2001 13:32:10 -0600, Jeff Hartmann wrote:
 
> > Would it not be a bit more robust to have a wrapper module that pulls in
> > the correct one on demand? In other words, for the radeon, you would
> > still have the radeon.o module, but it would determine which child
> > module to load depending on the version of X that is requesting it. Thus
> > XFree86 would not require any changes and the backwards compatibility
> > would be maintained invisibly.
> > 
> > John
> > 
> No, because the 2D ddx module is the one doing all the versioning.  It 
> doesn't tell the kernel its version number etc., but the ddx module gets 
> the version from the kernel, and fails if its the wrong one.  If the 
> kernel was the one doing the checking, then your suggestiong would be a 
> nice way of handling it.

Well ... you're gonna change the API anyway, so you could add that in
the protocol.
Still, I'm a bit disappointed with this ever-changing API. A bit
un-linux if you ask me.

Xav

