Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbVHPURc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbVHPURc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVHPURc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:17:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59340 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932695AbVHPURb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:17:31 -0400
Date: Tue, 16 Aug 2005 13:17:21 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
Message-Id: <20050816131721.5533253a.zaitcev@redhat.com>
In-Reply-To: <mailman.1124063520.13257.linux-kernel2news@redhat.com>
References: <42FDE286.40707@v.loewis.de>
	<feed8cdd0508130935622387db@mail.gmail.com>
	<1123958572.11295.7.camel@mindpipe>
	<ufazmrl9h3u.fsf@epithumia.math.uh.edu>
	<feed8cdd050814125845fe4e2e@mail.gmail.com>
	<1124049592.4918.2.camel@mindpipe>
	<mailman.1124063520.13257.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005 00:55:54 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2005-08-14 at 15:59 -0400, Lee Revell wrote:

> > I know the alternatives are available.  That doesn't make it any less
> > idiotic to use non ASCII characters as operators.  I think it's a very
> > slippery slope.  We write code in ASCII, dammit.
> 
> Its a trivial patch and there is a lot to be said for UTF-8 scripts. As
> to writing code in ascii, the kernel regularly has outbreaks of either
> UTF-8 or ISO-8859-* especially in the docs directory. Standardising
> these on UTF-8 would be helpful.
> 
> Yes the kernel code is C so ASCII except for the odd abuser of the ©
> symbol.

We write kernel code in ASCII because of patches in e-mail. When a patch
is saved (often by a script), it is divorced of the encoding in which
e-mail was done. Forwarding of patches then causes them to fail to apply.
Everything else can be worked around.

In my experience, the most common case of such patch rejects has to do
with a European using a non-UTF-8 encoding for his name, rather than
with the copyright symbol.

-- Pete
