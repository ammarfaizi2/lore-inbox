Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946215AbWJSQkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946215AbWJSQkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946216AbWJSQkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:40:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21189 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946215AbWJSQko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:40:44 -0400
Subject: Re: VCD not readable under 2.6.18
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: wixor <wixorpeek@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c43b2e150610190935tefd11eev510c7dee36c15a51@mail.gmail.com>
References: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com>
	 <1161040345.24237.135.camel@localhost.localdomain>
	 <c43b2e150610171116w2d13e47ancbea07c09bd5ffbf@mail.gmail.com>
	 <1161124732.5014.20.camel@localhost.localdomain>
	 <c43b2e150610190935tefd11eev510c7dee36c15a51@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 17:42:58 +0100
Message-Id: <1161276178.17335.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 18:35 +0200, ysgrifennodd wixor:
> OK, but this is still mountable only from windows....... Is this ISO
> filesystem hidden somewhere, or what? And that still does not explain

It isn't hidden it should be in the first session

> errors from xine, and the 8 megs that i actually can read using dd.
> All after all - even if this disc would contain totally unsupported
> tracks, with absolutly weird data, kernel should recognize it and
> report something like:

The different types aren't per track but per sector.

> this just another hell-knows-what thing, the kernel implementation is
> ok, and this is only some m$-dontated extension that prevents us from
> accessing this disc? Even if it is, shouldn't it be implemented if it
> is possible?

Actually all the VCD stuff is a mix of the Chinese government and
Philips. The specs are available although pricy.

The kernel provides the infrastructure for arbitary CD handling, but
provides only the file system support in kernel. It can't (and doesn't
appear to need to) handle VCD in kernel it provides the tools to Xine
and friends instead.

Alan

