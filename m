Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTE3W2a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbTE3W2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:28:30 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:42166 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263996AbTE3W23 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:28:29 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 30 May 2003 15:39:19 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
In-Reply-To: <20030530222630.GF3308@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.55.0305301535100.4421@bigblue.dev.mcafeelabs.com>
References: <20030530212013.GE3308@wohnheim.fh-wedel.de>
 <Pine.LNX.4.44.0305301431390.2671-100000@home.transmeta.com>
 <20030530222630.GF3308@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, [iso-8859-1] Jörn Engel wrote:

> On Fri, 30 May 2003 14:38:07 -0700, Linus Torvalds wrote:
> > On Fri, 30 May 2003, Jörn Engel wrote:
> > >
> > > How about an all or nothing approach?  If you really want to get rid
> > > of K&R, change indentation as well, rip out some of the rather
> > > tasteless macros (ZEXPORT, ZEXPORTVA, ZEXTERN, FAR, ...) and so on.
> >
> > I'd love to, but I suspect we lack the motivation to do so, and there
> > aren't any obvious upsides. Yes, the code is ugly, but it's also fairly
> > stable so people seldom need to look at it.
>
> Well, since I'm currently working on the zlib anyway...

Talking about the code, there are still a bunch of files that uses spaces
with tabsize=4. Shouldn't those be reformatted with real TABs ? An emacs
lisp (indent+tabify) might do it pretty fast ...



- Davide

